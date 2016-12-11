class Position
  attr_accessor :col, :row
  def initialize(col, row)
    @row = row
    @col = col
  end
  def go(heading)
    if heading == Player::UP
      @row -= 1
    elsif heading == Player::RIGHT
      @col += 1
    elsif heading == Player::DOWN
      @row += 1
    elsif heading == Player::LEFT
      @col -= 1
    end
  end

  def ==(other_thing)
    @row == other_thing.row && @col == other_thing.col
  end

  def summary
    "col: #{col}, row: #{row}"
  end
end
