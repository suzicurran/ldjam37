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
    @board_sprites[0].draw(0,0,0)
    @board_sprites[1].draw(0,50,0)
    @board_sprites[2].draw(0,150,0)
    @board_sprites[3].draw(0,200,0)

  end
end
