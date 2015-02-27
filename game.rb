require_relative 'board'
require_relative 'piece'
require_relative 'colors'
require_relative 'player'
require 'colorize'
require 'byebug'

class Game
  attr_reader :board, :players

  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new
  end

  def run
    board.setup
    turn = 0
    until over?
      current_player = players[turn % 2]
      current_player.play_turn(board)
      board.promote_pieces
      turn += 1
    end
  end

  def over?
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new(:red), Player.new(:black))
  game.run
end
