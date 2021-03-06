# encoding: UTF-8

require './piece.rb'

# maintains board state separately from who has things to do when
# implements the rules of checkers, where the Game class
# manages the players and what they need to do
class Board
  attr_reader :white_pieces, :black_pieces
  attr_accessor :jumping_piece, :turn, :other_turn
  # golf-y way of writing every pair of values between 0 and 7 that sum to odd
  VALID_POS = (0..7).map do |i|
                (0..7).map do |j|
                  [i, j] if (i + j).odd?
                end
              end.flatten(1).compact

  def initialize(blank = false, turn = :white, other_turn = :black)
    @turn, @other_turn = turn, other_turn unless blank
    @white_pieces, @black_pieces = [], []
    make_pieces unless blank
    self
  end

  def pieces
    @white_pieces + @black_pieces
  end

  def over?
    return true if @white_pieces.empty? || @black_pieces.empty?
    pieces.none? { |piece| jumps?(piece) || slides?(piece) }
  end

  def move(player_move)
    pos, dir = player_move
    piece = piece_at(pos)

    fail 'NO PIECE THERE' if piece.nil?
    fail 'NOT YOUR PIECE' unless piece.color == @turn
    fail 'BAD MOVE DIRECTION' unless piece.directions.include?(dir)

    if can_slide?(piece, dir)
      fail 'SLID OFF BOARD' unless VALID_POS.include?(piece.slide_pos(dir))
      fail 'MUST KEEP JUMPING' unless @jumping_piece.nil?
      piece.slide(dir)
    elsif can_jump?(piece, dir)
      fail 'JUMP OFF BOARD' unless VALID_POS.include?(piece.jump_pos(dir))
      piece.jump(dir)
      @jumping_piece = piece
    else
      fail 'CANNOT SLIDE OR JUMP'
    end

    toggle_turn
  end

  def can_slide?(piece, dir)
    # can slide if no piece in the way
    self.empty?(piece.slide_pos(dir))
  end

  def can_jump?(piece, dir)
    return false if piece.nil?
    return false if piece_at(piece.slide_pos(dir)).nil?
    return false unless VALID_POS.include?(piece.jump_pos(dir))

    return false unless empty?(piece.jump_pos(dir))
    piece_at(piece.slide_pos(dir)).color != piece.color
  end

  def jumps?(piece)
    piece.directions.any? { |dir| can_jump?(piece, dir) }
  end

  def slides?(piece)
    piece.directions.any? { |dir| can_slide?(piece, dir) }
  end

  # switches the turn unless the jumping piece can make more jumps
  def toggle_turn
    return nil unless jumping_piece.nil? || !jumps?(jumping_piece)
    @turn, @other_turn = @other_turn, @turn
    @jumping_piece = nil
  end

  def piece?(pos)
    piece_at(pos) ? true : false
  end

  def empty?(pos)
    return false unless VALID_POS.include?(pos)
    !piece?(pos)
  end

  def piece_at(pos)
    pieces.find { |piece| piece.row == pos[0] && piece.col == pos[1] }
  end

  def remove_at(pos)
    @white_pieces.delete_if { |p| p.row == pos[0] && p.col == pos[1] }
    @black_pieces.delete_if { |p| p.row == pos[0] && p.col == pos[1] }
  end

  protected

  def make_pieces
    # put black pieces in the top four rows
    VALID_POS.each do |row, col|
      @black_pieces << Piece.new([row, col], :black, self) if row < 3
    end

    # put white pieces in the bottom four rows
    VALID_POS.each do |row, col|
      @white_pieces << Piece.new([row, col], :white, self) if row > 4
    end
  end
end
