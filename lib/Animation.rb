class Animation
  def initialize(sprite_sheet_path, width, height, fps, x, y, z, sprite_sheet_frames = (0..-1))
    @fps = fps
    origin_sprites = Gosu::Image.load_tiles(sprite_sheet_path, width, height)
    @my_sprites = origin_sprites[sprite_sheet_frames]
    @x = x
    @y = y
    @z = z
    @fps_counter = (60/fps)
    @animation_counter = 0
  end
  def update
    if (Game.frame_count % @fps_counter) == 0
      @animation_counter += 1
    end
  end
  def draw
    index = @animation_counter % @my_sprites.length
    @my_sprites[index].draw(@x, @y, @z)
  end
end
