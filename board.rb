# encoding: UTF-8

require './piece.rb'

# TASKS
# Give board state to players
# move a piece at a location in a direction
# keep track of whose turn it is
# keep track of where all the pieces are
# keep track of which piece, if any, is in the middle of a series of jumps
class Board
  attr_reader :white_pieces, :black_pieces
  attr_accessor :jumping_piece, :turn, :other_turn
  # golf-y way of writing every pair of values between 0 and 7 that sum to odd
  VALID_POSITIONS = (0..7).map do |i|
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

  def legal_pieces
    player_pieces = turn == :white ? white_pieces : black_pieces
    player_pieces = [jumping_piece] unless jumping_piece.nil?
    player_pieces.select { |piece| piece.can_move? }
  end

  def over?
    false # stubbed
  end

  # def move(player_move)
  #   pos, direction = player_move
  #   moving_piece = piece_at(pos)
  #
  #   fail 'That is not your piece' unless moving_piece.color == turn
  #
  #   if jumping_piece
  #     fail 'You have to keep jumping!' unless jumping_piece == moving_piece
  #     jumping_piece.jump(direction)
  #   else
  #     # see if you move or slide in this direction
  #   end
  #
  #   jumped = moving_piece.move(direction)
  #   jumping_piece = moving_piece if jumped
  #
  #   nil # stubbed
  # end
  # NEEDS A REFACTOR AND SOME RETHINKING

  def move(player_move)
    pos, direction = player_move
    moving_piece = piece_at(pos)

    # check if it's valid
    fail 'INVALID MOVE!' unless valid_move?(pos, direction)

    # make the move
    @jumping_piece = moving_piece if moving_piece.move(direction) # made a jump

    # toggle the turn if necessary
    toggle_turn
  end

  def valid_move?(pos, direction)
    true # stubbed
  end

  # switches the turn unless the jumping piece can make more jumps
  def toggle_turn
    unless jumping_piece.nil? || jumping_piece.can_jump?
      @turn, @other_turn = @other_turn, @turn
      @jumping_piece = nil
    end
  end

  def piece?(pos)
    false # stubbed
  end

  def piece_at(pos)
    pieces.find { |piece| piece.row == pos[0] && piece.col == pos[1]}
  end

  def remove_at(pos)
    @white_pieces.delete_if { |p| p.row == pos[0] && p.col == pos[1]}
    @black_pieces.delete_if { |p| p.row == pos[0] && p.col == pos[1]}
  end

  protected

  def make_pieces
    # put black pieces in the top four rows
    VALID_POSITIONS.each do |row, col|
      @black_pieces << Piece.new([row, col], :black, self) if row < 3
    end

    # put white pieces in the bottom four rows
    VALID_POSITIONS.each do |row, col|
      @white_pieces << Piece.new([row, col], :white, self) if row > 4
    end
  end
end
