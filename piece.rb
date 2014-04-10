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
    directions.any? { |dir| can_jump_in?(dir) }
  end

  def can_jump_in?(dir)
    return false unless @board.piece?(next_pos_in(dir))
    @board.piece_at(next_pos_in(dir)).color != self.color
  end

  def can_move?
    directions.any? { |dir| can_move_in?(dir) }
  end

  def can_move_in?(dir)
    can_jump_in?(dir) || !@board.piece?(next_pos_in(dir))
  end

  # make a move in the given direction. Returns true if it jumped, else false
  def move(dir)
    if can_jump_in?(dir)
      jump(dir)
    elsif !@board.piece?(next_pos_in(dir)) # slide if free
      slide(dir)
    else
      fail "CAN'T MOVE LIKE THAT"
    end
  end

  # attempts to jump in the given direction
  def jump(dir)
    @board.remove_at(next_pos_in(dir))
    @row, @col = next_pos_in(dir)
    @row, @col = next_pos_in(dir)
    true
  end

  # attempts to slide in the given direction
  def slide(dir)
    @row, @col = next_pos_in(dir)
    false
  end

  def disp_str
    color == :white ? 'X' : 'O'
  end

  # array of directions the piece can move in
  def directions
    return UP_DIRS + DOWN_DIRS if king
    self.color == :white ? UP_DIRS : DOWN_DIRS
  end

  protected

  def next_pos_in(dir)
    [row + dir[0], col + dir[1]]
  end
end
