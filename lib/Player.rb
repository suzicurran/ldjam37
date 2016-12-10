require 'pry'

PLAYER_TILE_WIDTH = 32
PLAYER_TILE_HEIGHT = 36
TILE_OFFSET = 4

class Player
  def initialize(p1_or_p2)
    @player_num = p1_or_p2
    player_data = {
      p1: {starting_position: {col: 1, row: 1},
           goal_position: {col: Game::TILES_PER_SIDE-2, row: Game::TILES_PER_SIDE - 2},
           sprite_sheet_path:'./Images/warrior_f.png',
           my_tiles: Tile::PLAYER_1_TILE},
      p2: {starting_position:  {col: Game::TILES_PER_SIDE-2, row: Game::TILES_PER_SIDE - 2},
           goal_position: {col: 1, row: 1},
           sprite_sheet_path: './Images/healer_f.png',
           my_tiles: Tile::PLAYER_2_TILE}
    }
    @my_data = player_data[@player_num]
    @my_sprites = Gosu::Image.load_tiles(@my_data[:sprite_sheet_path], PLAYER_TILE_WIDTH, PLAYER_TILE_HEIGHT)
  end
  def draw
    @my_sprites[7].draw(@my_data[:starting_position][:col]*Game::TILE_DIMENSIONS,(@my_data[:starting_position][:row]*Game::TILE_DIMENSIONS)-TILE_OFFSET,1)
  end
end
