class Piece
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position

    @king = false
  end

  def render
    font_color = black? ? :black : :light_red
    symbol = king? ? "♛" : "◉"
    symbol.colorize(color)
  end

  def black?
    color == :black
  end

  def red?
    color == :red
  end

  def king?
    @king
  end

  def promote
    @king = true
  end

  def promotable?
    goal_row = black? ? 7 : 0
    position.first == goal_row
  end

  def moves(board)
    attack_moves(board) || slide_moves(board)
  end

  def slide_moves(board)
    slide_moves = []
    x, y = position
    move_diffs.each do |x_shift, y_shift|
      slide_dest = [x + x_shift, y + y_shift]
      slide_moves << slide_dest if board.in_bounds?(slide_dest) && board[slide_dest].nil?
    end
    slide_moves
  end

  def attack_moves(board)
    attack_moves = []
    x, y = position
    move_diffs.each do |x_shift, y_shift|
      slide_dest = [x + x_shift, y + y_shift]
      attack_dest = [x + x_shift * 2, y + y_shift * 2]
      if board.in_bounds?(slide_dest) &&
         board.in_bounds?(attack_dest) &&
         enemy_piece?(board[slide_dest]) &&
         board[attack_dest].nil?
        attack_moves << attack_dest
      end
    end
    attack_moves.empty? ? nil : attack_moves
  end

  def enemy_piece?(piece)
    !(piece.nil? || piece.color == color)
  end

  def perform_move(move, board)
    attack = false
    mid = [(position.first + move.first) / 2, (position.last + move.last) / 2]
    if enemy_piece?(board[mid])
      board[mid] = nil
      attack = true
    end

    board[move] = self
    board[position] = nil
    @position = move

    attack
  end

  private

  def move_diffs
    return [[-1, 1], [1, 1], [-1, -1], [1, -1]] if king?
    black? ? [[1, -1], [1, 1]] : [[-1, -1], [-1, 1]]
  end

end
