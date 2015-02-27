require_relative 'keypress'

class InvalidMoveError < StandardError; end


class Player
  attr_reader :color, :cursor
  include Keypress

  def initialize(color)
    @color = color
    @cursor = [0, 0]
  end

  def play_turn(board)

    begin
      selection = get_selection(board)
      selected_piece = board[selection]
      move = get_move(selected_piece, board)
    rescue InvalidMoveError
      retry
    end

    attack = selected_piece.perform_move(move, board)

    while attack && selected_piece.attack_moves(board)
      begin
        move = get_move(selected_piece, board)
        attack = selected_piece.perform_move(move, board)
      rescue InvalidMoveError
        retry
      end
    end

  end

  def get_move(piece, board)
    raise InvalidMoveError.new if piece.nil? || piece.color != color
    moves = piece.moves(board)
    move = get_selection(board, moves + [piece.position])
    raise InvalidMoveError.new unless moves.include?(move)
    raise InvalidMoveError.new if move == piece.position
    move
  end

  def get_selection(board, highlights = [])
    loop do
      board.display(cursor, highlights)
      stroke = get_char
      case stroke
      when /[wasd]/
        move_cursor(stroke, board)
      when " "
        return cursor
      end
    end
  end

  def move_cursor(stroke, board)
    offsets = {
      'w' => [-1,0],
      'a' => [0,-1],
      's' => [1, 0],
      'd' => [0, 1]
    }
    x, y = cursor
    x_shift, y_shift = offsets[stroke]
    pos = [x + x_shift, y + y_shift]
    @cursor = pos if board.in_bounds?(pos)
  end

end
