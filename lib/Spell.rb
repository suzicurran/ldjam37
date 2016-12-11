class Spell

  attr_reader :position, :resulting_tile_type, :heading

  def initialize(position, heading, resulting_tile_type)
    @position = position
    @heading = heading
    @resulting_tile_type = resulting_tile_type
  end

  def update
    if Game.frame_count % 10 == 0
      @position.go(@heading)
    end
  end

  def draw

  end
end
