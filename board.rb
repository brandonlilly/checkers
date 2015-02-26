class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def setup
    (0..7).each do |row|
      (0..7).each do |col|
        if (row + col).even?
          @grid[row][col] = Piece.new(:black, [row, col]) if row < 3
          @grid[row][col] = Piece.new(:red, [row, col]) if row > 4
        end
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y] if in_bounds?(pos)
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value if in_bounds?(pos)
  end

  def in_bounds?(pos)
    x, y = pos
    raise "Invalid position x:#{x} y:#{y}" if x.nil? || y.nil?
    x.between?(0, 8) && y.between?(0, 8)
  end

  def render(selection = nil, highlights = [])
    @grid.each_with_index.map do |row, ri|
      row.each_with_index.map do |tile, ci|
        str = tile.nil? ? "   " : tile.render
        bg_color = (ri + ci).even? ? :white : :light_white
        bg_color = :magenta if [ri, ci] == selection
        bg_color = :light_yellow if highlights.include?([ri, ci])
        str.colorize(background: bg_color)
      end.join('')
    end
  end

  def display(selection = nil, highlights = [])
    puts '', render(selection, highlights), ''
  end

  def pieces(color = nil)
    pieces_arr = @grid.flatten.compact
    pieces_arr.select! { |piece| piece.color == color } unless color.nil?
    pieces_arr
  end

end
