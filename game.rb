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
    @players = { white: Player.new('TEST'), black: Player.new }
  end

  def play
    # play_turn until board.over?
    test_sequence
  end

  protected

  def test_sequence
    debugger
    players[:white].show_board(board)
    board.remove_at([5,2])
    board.remove_at([0,1])
    puts 'REMOVING A WHITE AND BLACK PIECE'
    players[:white].show_board(board)
    board.piece_at([5,0]).move([-1, 1])
    players[:white].show_board(board)
    board.piece_at([4,1]).move([-1, 1])
    players[:white].show_board(board)
    board.piece_at([2,1]).jump([1, 1])
    players[:white].show_board(board)
  end

  def play_turn
    players[@board.turn].show_board(@board)
    player_move = players[@board.turn].move # move is a position and a direction
    @board.move(player_move)
  end
end

Game.new.play
