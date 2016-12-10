class Tile

  WALL = 0
  GREY = 1
  RED = 2
  BLUE = 3

  def initialize(column_index, row_index)
    @column_index = column_index  # x value w/ index starting at 0
    @row_index = row_index # y value w/ index starting at 0
    path_to_tile_image = './Images/Tiles.png'
    @board_sprites = Gosu::Image.load_tiles(path_to_tile_image, Game::TILEDIMENSIONS, Game::TILEDIMENSIONS)
    @tile_color = GREY
    if is_a_wall?
      @tile_color = WALL
    end
  end

  def is_a_wall?
    wall_locations = [0, (Game::TILES_PER_SIDE - 1)]
    wall_locations.include?(@column_index) || wall_locations.include?(@row_index)
  end

  def change_color(target_color)
    @tile_color = target_color
  end

  def draw
    @board_sprites[@tile_color].draw(@column_index*Game::TILEDIMENSIONS,@row_index*Game::TILEDIMENSIONS,0)
  end
end
