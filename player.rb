# encoding: UTF-8

# needs two methods:
# 1. Show the player the board
# 2. Get a move from the player
# also want to store the name of the player
class Player
  attr_reader :name
  BLANK_BOARD = (' ' * 8 + "\n") * 8
  DIRECTIONS = { 9 => [-1, 1],
    7 => [-1, -1],
    1 => [1, -1],
    3 => [1, 1] }

  def initialize(name = 'BOB LOBLAW')
    @name = name
  end

  def show_board(board)
    disp_board = BLANK_BOARD.dup
    board.pieces.each do |piece|
      disp_board[loc_to_ind(piece.row, piece.col)] = piece.disp_str
    end
    puts
    puts disp_board
    puts
  end

  def move
    # returns an array [pos, direction]
    # parsing logic from user input to game logic happens here
    # under penalty of bugs
    puts "#{name}, please enter where to move what direction (ie, 1,1,7)"
    move_arr = gets.chomp.split(',').map(&:to_i)
    [[move_arr[0], move_arr[1]], DIRECTIONS[move_arr[2]]]
  end

  protected

  def loc_to_ind(row, col)
    row * 9 + col
  end
end
