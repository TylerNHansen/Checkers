# encoding: UTF-8

# each piece needs to keep track of what board it is on, and where it is
# task: move itself in a specified direction. Throw an error if it can't.
# jump if it can jump. Otherwise, slide. Tell the board if it slid or jumped.
class Piece
  attr_reader :row, :col, :color, :board, :king

  UP_DIRS = [[-1, 1], [-1, -1]]
  DOWN_DIRS = [[1, 1], [1, -1]]

  # position is going to be stored internally as [row, col]
  def initialize(position, color, board, king = false)
    @row, @col = position
    @color, @board, @kind = color, board, king
  end

  def inspect
    "#{color} piece at #{row}, #{col}"
  end

  # needs to be able to tell the board if it can jump
  def can_jump?
    false # stubbed
  end

  def can_move?
    directions.any? { |dir| can_move_in?(dir) }
  end

  def can_move_in?(dir)
    # returns true if you can move or jump in that direction
  end

  # make a move in the given direction. Returns true if it jumped, else false
  def move(direction)
    # need the logic for if jump in the direction
    slide(direction)
  end

  # attempts to jump in the given direction
  def jump(direction)
    @board.remove_at([row + direction[0], col + direction[1]])
    @row, @col = [row + 2 * direction[0], col + 2 * direction[1]]
  end

  # attempts to slide in the given direction
  def slide(direction)
    @row, @col = [row + direction[0], col + direction[1]]
  end

  def disp_str
    color == :white ? 'X' : 'O'
  end

  # array of directions the piece can move in
  def directions
    return UP_DIRS + DOWN_DIRS if king
    color == white ? UP_DIRS : DOWN_DIRS
  end
end
