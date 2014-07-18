# encoding: UTF-8

# require 'debugger'

class Player
  attr_reader :name
  # BLANK_BOARD = (' ' * 8 + "|\n") * 8
  BLANK_BOARD = (0..7).map { |i| "#{i}" + ' ' * 8 + "#{i}\n" }.join('')
  DIRECTIONS = { 9 => [-1, 1],
                 7 => [-1, -1],
                 1 => [1, -1],
                 3 => [1, 1] }

  def initialize(name = 'BLACK')
    @name = name
  end

  def show_board(board)
    disp_board = BLANK_BOARD.dup
    board.pieces.each do |piece|
      disp_board[loc_to_ind(piece.row, piece.col)] = piece.disp_str
    end
    puts ' 01234567'
    puts disp_board
    puts ' 01234567'
  end

  def move
    # returns an array [pos, direction]
    # parsing logic from user input to game logic happens here
    puts "#{name}, please enter row, column, and numpad direction (eg 5,0,9)"
    move_arr = gets.chomp.split(',').map(&:to_i)
    [[move_arr[0], move_arr[1]], DIRECTIONS[move_arr[2]]]
  end

  protected

  def loc_to_ind(row, col)
    row * 11 + col + 1
  end
end

# Automatically reads a series of moves from testmoves.txt. When out of moves,
# asks the console for more moves
class TestPlayer < Player
  @@moves = File.open('testmoves2.txt').each_line.map(&:chomp)
  def move
    if @@moves.empty?
      super
    else
      move_arr = @@moves.shift.split(',').map(&:to_i)
      puts
      puts "trying #{move_arr}"
      [[move_arr[0], move_arr[1]], DIRECTIONS[move_arr[2]]]
    end
  end
end
