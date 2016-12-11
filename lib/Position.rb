class Position
  attr_accessor :row, :col
  def initialize(row, col)
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
end
