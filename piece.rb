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

  # forces a jump in the given direction, removing a piece it jumps over
  def jump(dir)
    @board.remove_at(slide_pos(dir))
    @row, @col = jump_pos(dir)
    nil
  end

  # forces a slide in the given direction
  def slide(dir)
    @row, @col = slide_pos(dir)
    nil
  end

  def disp_str
    color == :white ? 'X' : 'O'
  end

  # array of directions the piece can move in
  def directions
    return UP_DIRS + DOWN_DIRS if king
    self.color == :white ? UP_DIRS : DOWN_DIRS
  end

  def slide_pos(dir)
    [row + dir[0], col + dir[1]]
  end

  def jump_pos(dir)
    [row + 2 * dir[0], col + 2 * dir[1]]
  end
end
