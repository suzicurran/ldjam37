require 'pry'

class Player
  @@player_data = {
    p1: {starting_position: Position.new(1,1),
         goal_position: Position.new(GameConfig::GAME_TILES_PER_SIDE-2, GameConfig::GAME_TILES_PER_SIDE - 2),
         sprite_sheet_path:'./Images/warrior_f.png',
         my_tiles: Tile::PLAYER_1_TILE},
    p2: {starting_position:  Position.new(GameConfig::GAME_TILES_PER_SIDE-2, GameConfig::GAME_TILES_PER_SIDE - 2),
         goal_position: Position.new(1,1),
         sprite_sheet_path: './Images/healer_f.png',
         my_tiles: Tile::PLAYER_2_TILE}
  }
  def initialize(p1_or_p2)
    @player_num = p1_or_p2
    @my_data = @@player_data[@player_num]
    @my_sprites = Gosu::Image.load_tiles(@my_data[:sprite_sheet_path], GameConfig::PLAYER_TILE_WIDTH, GameConfig::PLAYER_TILE_HEIGHT)
  end
  def self.starting_player_data
    return @@player_data
  end
  def draw
    @my_sprites[7].draw(@my_data[:starting_position].row*GameConfig::GAME_TILE_DIMENSIONS,(@my_data[:starting_position].col*GameConfig::GAME_TILE_DIMENSIONS)-GameConfig::PLAYER_TILE_OFFSET,1)
  end
end
