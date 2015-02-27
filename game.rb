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
    turn = 0

    board.setup

    loop do
      current_player = players[turn % 2]
      piece, move = current_player.play_turn(board)
      board.promote_pieces
      turn += 1
    end
  end
  
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new(:red), Player.new(:black))
  game.run
end
