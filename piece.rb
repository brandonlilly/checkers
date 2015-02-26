class Piece
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position

    @king = false
  end

  def render
    font_color = black? ? :black : :light_red
    " ◉ ".colorize(color)
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

  def make_king
    @king = true
  end

  def moves(board)
    slide_moves = []
    attack_moves = []
    x, y = position
    # debugger
    move_diffs.each do |x_shift, y_shift|
      slide_dest = [x + x_shift, y + y_shift]
      attack_dest = [x + x_shift * 2, y + y_shift * 2]
      if board.in_bounds?(slide_dest)
        slide_moves << slide_dest if board[slide_dest].nil?
        if board.in_bounds?(attack_dest) &&
           enemy_piece?(board[slide_dest]) &&
           board[attack_dest].nil?
          attack_moves << attack_dest if enemy_piece?(board[slide_dest]) && board[attack_dest].nil?
        end
      end
    end

    attack_moves.empty? ? slide_moves : attack_moves
  end

  def enemy_piece?(piece)
    !piece.nil? && piece.color != color
  end

  def move_diffs
    return [[-1, 1], [1, 1], [-1, -1], [-1, 1]] if king?
    black? ? [[1, -1], [1, 1]] : [[-1, -1], [-1, 1]]
  end

  def perform_slide

  end

  def perform_jump

  end

end
