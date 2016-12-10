require 'hasu'
require 'pry'

Hasu.load './lib/Player.rb'
Hasu.load './lib/Tile.rb'

class Game < Hasu::Window

  TILEDIMENSIONS = 32

  def initialize(tiles_per_side = 50)
    @tiles_per_side = tiles_per_side
    super(@tiles_per_side * TILEDIMENSIONS, @tiles_per_side * TILEDIMENSIONS)
  end

  def reset
    self.caption = 'Capture the other base!'
    @game_tiles = []
    @tiles_per_side.times do |index_for_column|
      @tiles_per_side.times do |index_for_row|
        this_tile = Tile.new(index_for_column, index_for_row)
        @game_tiles << this_tile
      end
    end
    binding.pry
  end

  def update
  end

  def draw
  end
end

Game.run
