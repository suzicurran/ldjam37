require 'hasu'
require 'pry'

Hasu.load './lib/GameConfig.rb'
Hasu.load './lib/Position.rb'
Hasu.load './lib/Tile.rb'
Hasu.load './lib/Player.rb'


class Game < Hasu::Window

  def initialize
    super(GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS)
  end

  def reset
    self.caption = "Reach your opponent's home to win!"
    @game_tiles = []
    GameConfig::GAME_TILES_PER_SIDE.times do |index_for_column|
      GameConfig::GAME_TILES_PER_SIDE.times do |index_for_row|
        this_tile = Tile.new(index_for_column, index_for_row)
        @game_tiles << this_tile
      end
    end
    top_right_position = Position.new(GameConfig::GAME_TILES_PER_SIDE-2,1)
    bottom_left_position = Position.new(1, GameConfig::GAME_TILES_PER_SIDE - 2)
    bottom_right_position = Position.new(GameConfig::GAME_TILES_PER_SIDE-2, GameConfig::GAME_TILES_PER_SIDE - 2)
    top_left_position = Position.new(1,1)
    @p1 = Player.new( top_right_position, bottom_right_position, './Images/warrior_f.png')
    @p2 = Player.new( bottom_left_position, top_left_position, './Images/healer_f.png')
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
