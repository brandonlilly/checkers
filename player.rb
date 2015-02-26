require_relative 'keypress'

class Player
  attr_reader :color, :selection
  include Keypress

  def initialize(color)
    @color = color
    @selection = [0, 0]
  end

  def play_turn(board)
    stroke = get_char
    case stroke
    when /[wasd]/
      move_selection(stroke, board)
    end
    puts stroke

    moves = []
    piece = board[selection]
    if board.pieces(color).include?(piece)
      moves = piece.moves(board)
    end

    board.display(selection, moves)
  end

  def move_selection(stroke, board)
    offsets = {
      'w' => [-1,0],
      'a' => [0,-1],
      's' => [1, 0],
      'd' => [0, 1]
    }
    x, y = @selection
    x_shift, y_shift = offsets[stroke]
    pos = [x + x_shift, y + y_shift]
    @selection = pos if board.in_bounds?(pos)
  end

end
