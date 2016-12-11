require 'pry'

class Player

  def initialize(starting_position, goal_position, sprite_sheet_path)
    @position = starting_position
    @goal_position = goal_position
    @my_sprites = Gosu::Image.load_tiles(sprite_sheet_path, GameConfig::PLAYER_TILE_WIDTH, GameConfig::PLAYER_TILE_HEIGHT)
  end

  def self.starting_player_data
    return @@player_data
  end

  def wins?
    @position == @goal_position
  end

  def draw
    @my_sprites[7].draw(@position.row*GameConfig::GAME_TILE_DIMENSIONS,@position.col*GameConfig::GAME_TILE_DIMENSIONS-GameConfig::PLAYER_TILE_OFFSET,1)
  end
end
