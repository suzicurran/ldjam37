class Spell
  def initialize(position, heading, color)
    @position = position
    @heading = heading
    @color = color
  end

  def update
    if Game.frame_count % 10 == 0
      @position.go(@heading)
    end
  end

  def draw

  end
end
