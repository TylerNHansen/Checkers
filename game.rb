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
    @players = { white: TestPlayer.new('TEST'), black: TestPlayer.new }
  end

  def play
    # test_sequence
    30.times do
      begin
        play_turn
      rescue => e
        puts "That is not a valid move: #{e.message}"
      end
    end
    debugger
    play_turn
  end

  protected

  def test_sequence
    debugger
    players[:white].show_board(board)
    board.remove_at([5,2])
    board.remove_at([0,1])
    board.remove_at([1,4])

    puts 'REMOVING A WHITE AND BLACK PIECE'
    players[:white].show_board(board)

    puts 'MAKING SOME MOVES, SLIDES AND SINGLE JUMPS'
    board.move([[5, 0], [-1, 1]])
    players[:white].show_board(board)
    board.move([[4, 1], [-1, 1]])
    players[:white].show_board(board)
    board.move([[2, 1], [1, 1]])
    players[:white].show_board(board)
    board.move([[5, 4], [-1, -1]])
    debugger
    board.move([[3, 2], [-1, 1]])
    players[:white].show_board(board)

    # puts 'TRYING TO MOVE A NON-PIECE MOVE'
    # board.piece_at([2,1]).move([1, 1])
    # players[:white].show_board(board)


  end

  def play_turn
    players[@board.turn].show_board(@board)
    player_move = players[@board.turn].move # move is a position and a direction
    @board.move(player_move)
  end
end

Game.new.play
