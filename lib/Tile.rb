class Tile
  def initialize(column_index, row_index)
    @column_index = column_index  # x value w/ index starting at 0
    @row_index = row_index # y value w/ index starting at 0
    path_to_tile_image = './Images/Tiles.png'
    @board_sprites = Gosu::Image.load_tiles(path_to_tile_image, Game::TILEDIMENSIONS, Game::TILEDIMENSIONS)
  end

  def change_color(target_color)
  end

  def draw
    @board_sprites[0].draw(@column_index*Game::TILEDIMENSIONS,@row_index*Game::TILEDIMENSIONS,0)
  end
end
