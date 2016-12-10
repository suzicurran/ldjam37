require 'hasu'
require 'pry'

Hasu.load './lib/Player.rb'
Hasu.load './lib/Tile.rb'

class Game < Hasu::Window

  TILE_DIMENSIONS = 32 # in px
  TILES_PER_SIDE = 25

  def initialize
    super(TILES_PER_SIDE * TILE_DIMENSIONS, TILES_PER_SIDE * TILE_DIMENSIONS)
  end

  def reset
    self.caption = "Reach your opponent's home to win!"
    @game_tiles = []
    TILES_PER_SIDE.times do |index_for_column|
      TILES_PER_SIDE.times do |index_for_row|
        this_tile = Tile.new(index_for_column, index_for_row)
        @game_tiles << this_tile
      end
    end
    @p1 = Player.new(:p1)
    @p2 = Player.new(:p2)
  end

  def update
  end

  def draw
    @game_tiles.each do |tile|
      tile.draw
    end
    @p1.draw
    @p2.draw
  end
end

Game.run
