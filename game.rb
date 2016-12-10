require 'gosu'
require 'hasu'

class Game < Hasu::Window
  def initialize(size = 50)
    @size = size
    @tilesize = 32
    super(@size * @tilesize, @size * @tilesize)
  end

  def reset
    self.caption = 'Capture the other base!'
  end

  def update
  end

  def draw
  end
end

Game.run
