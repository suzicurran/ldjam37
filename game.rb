require 'hasu'
require 'pry'

Hasu.load './lib/GameConfig.rb'
Hasu.load './lib/Position.rb'
Hasu.load './lib/Tile.rb'
Hasu.load './lib/Board.rb'
Hasu.load './lib/Player.rb'


class Game < Hasu::Window

  def initialize
    super(GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS)
  end

  def reset
    self.caption = "Spread your magic to reach your goal!"
    @top_right_position = Position.new(GameConfig::GAME_TILES_PER_SIDE-2,1)
    @bottom_left_position = Position.new(1, GameConfig::GAME_TILES_PER_SIDE - 2)
    @bottom_right_position = Position.new(GameConfig::GAME_TILES_PER_SIDE-2, GameConfig::GAME_TILES_PER_SIDE - 2)
    @top_left_position = Position.new(1,1)
    @board = Board.new(@top_left_position, @bottom_right_position)
    @p1 = Player.new( @bottom_right_position, @bottom_right_position, './Images/Characters/warrior_f.png')
    @p2 = Player.new( @top_left_position, @top_left_position, './Images/Characters/healer_f.png')
  end

  def update
  end

  def draw
    @board.draw
    @p1.draw
    @p2.draw
  end
end

Game.run
