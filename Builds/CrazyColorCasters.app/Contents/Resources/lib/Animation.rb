class Animation
  def initialize(sprite_sheet_path, width, height, fps, sprite_sheet_frames = (0..-1))
    origin_sprites = Gosu::Image.load_tiles(sprite_sheet_path, width, height)
    @my_sprites = []
    if sprite_sheet_frames.is_a?(Range)
      @my_sprites = origin_sprites[sprite_sheet_frames]
    elsif sprite_sheet_frames.is_a?(Array)
      origin_sprites.each_with_index do |sprite, index|
        if sprite_sheet_frames.include?(index)
          @my_sprites << sprite
        end
      end
    end
    @fps = fps
    @fps_counter = (60/fps)
    @animation_counter = 0
  end
  def update
    if (Game.frame_count % @fps_counter) == 0
      @animation_counter += 1
    end
  end
  def draw(x,y,z)
    index = @animation_counter % @my_sprites.length
    @my_sprites[index].draw(x, y, z)
  end
end
