require 'hasu'
require 'pry'

Hasu.load './lib/Player.rb'
Hasu.load './lib/Tile.rb'

class Game < Hasu::Window

  TILEDIMENSIONS = 32 # in px
  TILES_PER_SIDE = 25

  def initialize
    super(TILES_PER_SIDE * TILEDIMENSIONS, TILES_PER_SIDE * TILEDIMENSIONS)
  end

  def reset
    # @tile = Tile.new(0,0)
    self.caption = 'Capture the other base!'
    @game_tiles = []
    TILES_PER_SIDE.times do |index_for_column|
      TILES_PER_SIDE.times do |index_for_row|
        this_tile = Tile.new(index_for_column, index_for_row)
        @game_tiles << this_tile
      end
    end
  end

  def update
  end

  def draw
    @game_tiles.each do |tile|
      tile.draw
    end
  end
end

Game.run
