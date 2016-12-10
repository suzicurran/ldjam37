class Tile

  WALL = 0
  GREY = 1
  PLAYER_1_TILE = 2
  PLAYER_2_TILE = 3

  def initialize(column_index, row_index)
    @p1_base_position = {col: 1, row: 1}
    @p2_base_position = {col: (Game::TILES_PER_SIDE - 2), row: (Game::TILES_PER_SIDE - 2)}
    @column_index = column_index  # x value w/ index starting at 0
    @row_index = row_index # y value w/ index starting at 0
    path_to_tile_image = './Images/Tiles.png'
    @board_sprites = Gosu::Image.load_tiles(path_to_tile_image, Game::TILE_DIMENSIONS, Game::TILE_DIMENSIONS)
    @tile_color = GREY
    if is_a_wall?
      @tile_color = WALL
    end
    if is_position?(@p1_base_position)
      @tile_color = PLAYER_1_TILE
    end
    if is_position?(@p2_base_position)
      @tile_color = PLAYER_2_TILE
    end
  end

  def is_position?(position)
    (@column_index == position[:col]) && (@row_index == position[:row])
  end

  def is_a_wall?
    wall_locations = [0, (Game::TILES_PER_SIDE - 1)]
    wall_locations.include?(@column_index) || wall_locations.include?(@row_index)
  end

  def change_color(target_color)
    @tile_color = target_color
  end

  def draw
    @board_sprites[@tile_color].draw(@column_index*Game::TILE_DIMENSIONS,@row_index*Game::TILE_DIMENSIONS,0)
  end
end
