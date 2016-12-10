require 'gosu'
require 'hasu'

class Game < Hasu::Window
  def initialize(size = 500)
    @size = size
    super(@size, @size)
  end

  def reset
  end

  def update
  end

  def draw
  end
end

Game.run
