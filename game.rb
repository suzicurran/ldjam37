require 'hasu'
require 'pry'

Hasu.load './lib/GameConfig.rb'
Hasu.load './lib/Position.rb'
Hasu.load './lib/Tile.rb'
Hasu.load './lib/Board.rb'
Hasu.load './lib/Player.rb'


class Game < Hasu::Window

  attr_reader :frame_count

  def initialize
    super(GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS)
  end

  def reset
    @frame_count = 0
    self.caption = "Flip tiles to your color to reach your goal!"
    @top_right_position = Position.new(GameConfig::GAME_TILES_PER_SIDE-2,1)
    @bottom_left_position = Position.new(1, GameConfig::GAME_TILES_PER_SIDE - 2)
    @bottom_right_position = Position.new(GameConfig::GAME_TILES_PER_SIDE-2, GameConfig::GAME_TILES_PER_SIDE - 2)
    @top_left_position = Position.new(1,1)
    #keybindings
    keybindings_1 = {
      up: Gosu::KbW,
      right: Gosu::KbD,
      down: Gosu::KbS,
      left: Gosu::KbA,
      right_shoot: Gosu::KbE,
      left_shoot: Gosu::KbQ
    }
    keybindings_2 = {
      up: Gosu::KbI,
      right: Gosu::KbL,
      down: Gosu::KbK,
      left: Gosu::KbJ,
      right_shoot: Gosu::KbO,
      left_shoot: Gosu::KbU
    }

    @board = Board.new(@top_left_position, @bottom_right_position)
    @p1 = Player.new( @bottom_right_position, @top_left_position, './Images/Characters/warrior_f.png', keybindings_1, self)
    @p2 = Player.new( @top_left_position, @bottom_right_position, './Images/Characters/healer_f.png', keybindings_2, self)
  end

  def update
    @p1.update
    @p2.update
  end

  def draw
    if @p1.wins?
      #yay
    elsif @p2.wins?
      #yay
    else
      @board.draw
      @p1.draw
      @p2.draw
    end
    @frame_count += 1
  end
end

Game.run
