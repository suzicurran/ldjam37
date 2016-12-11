class Tile

  WALL = 0
  GREY = 1
  PLAYER_1_TILE = 2
  PLAYER_2_TILE = 3
  PLAYER_2_GOAL = 4
  PLAYER_1_GOAL = 5

  attr_accessor :tile_color

  def initialize(column_index, row_index)
    @column_index = column_index  # x value w/ index starting at 0
    @row_index = row_index # y value w/ index starting at 0
    path_to_tile_image = './Images/Tiles/Tiles.png'
    @board_sprites = Gosu::Image.load_tiles(path_to_tile_image, GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILE_DIMENSIONS)
    @tile_color = GREY
  end

  def is_position?(position)
    (@column_index == position.col) && (@row_index == position.row)
  end

  def is_a_wall?(wall_locations)
    wall_locations.include?(@column_index) || wall_locations.include?(@row_index)
  end

  def change_color(target_color)
    @tile_color = target_color
  end

  def draw
    @board_sprites[@tile_color].draw(@column_index*GameConfig::GAME_TILE_DIMENSIONS,@row_index*GameConfig::GAME_TILE_DIMENSIONS,0)
  end
end
