# encoding: UTF-8

require './player.rb'
require './board.rb'
require 'debugger'

# High-level game control logic:
# 1. Get a player1 and player2.
# 2. Get a board. Board always has the white pieces go first.
# 3. Show the board to the current player.
# 4. Tell the current player to make a move
# 5. Check if the game is over. If it isn't, do 3 and 4 again.
# Move format is tentatively chosen as piece location + direction.
class Game
  attr_reader :board, :players
  def initialize
    @board = Board.new
    @players = { white: TestPlayer.new('WHITE'), black: TestPlayer.new }
  end

  def play
    # test_sequence
    until board.over?
      begin
        play_turn
      rescue => e
        puts "That is not a valid move: #{e.message}"
      end
    end
    @players[:white].show_board(@board)
    nil
  end

  protected

  def play_turn
    players[@board.turn].show_board(@board)
    player_move = players[@board.turn].move
    @board.move(player_move)
  end
end

Game.new.play
