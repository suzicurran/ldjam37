require 'pry'

class Player
  MOVE_LIMIT = 10

  UP = :up
  RIGHT = :right
  DOWN = :down
  LEFT = :left

  attr_reader :my_spells, :winning, :player_name

  def initialize(player_name, starting_position, goal_tile, sprite_sheet_path, keybindings, tile_type)
    @winning = false
    @player_name = player_name
    @position = starting_position
    @goal_tile = goal_tile
    @my_sprites = Gosu::Image.load_tiles(sprite_sheet_path, GameConfig::PLAYER_TILE_WIDTH, GameConfig::PLAYER_TILE_HEIGHT)
    @up_sprites = @my_sprites[0,3]
    @right_sprites = @my_sprites[3,3]
    @down_sprites = @my_sprites[6,3]
    @left_sprites = @my_sprites[9,3]
    @keybindings = keybindings
    @tile_type = tile_type
    @next_move_in = 0
    @facing = DOWN
    @step_count = 0
    @my_spells = []
  end

  def update(tiles)
    if Game.frame_count >= @next_move_in
      move(tiles)
    end
    fire
  end

  def self.starting_player_data
    return @@player_data
  end

  def movement_cooldown
    @next_move_in = (Game.frame_count + 15)
  end

  def fire
    if Gosu::button_down?(@keybindings[:right_shoot]) || Gosu::button_down?(@keybindings[:left_shoot])
      @my_spells << Spell.new(Position.new(potential_position.col, potential_position.row), @facing, @tile_type)
    end
  end

  def potential_position
    pos = Position.new(@position.col, @position.row)
    pos.go(@facing)
    pos
  end

  def move(tiles)
    @winning = false
    @keybindings.keys[0,4].each do |direction|
      if Gosu::button_down? @keybindings[direction]
        if @facing == direction
          facing_tile = tiles.find{|tile| tile.position == potential_position}
          if (facing_tile.tile_color == @tile_type) || (facing_tile.tile_color == @goal_tile)
            @position.go(direction)
            if (facing_tile.tile_color == @goal_tile)
              @winning = true
            end
            @step_count += 1
          end
        else
          @facing = direction
        end
        movement_cooldown
      end
    end
  end

  def draw
    if @facing == UP
      animate(@up_sprites)
    elsif @facing == RIGHT
      animate(@right_sprites)
    elsif @facing == DOWN
      animate(@down_sprites)
    elsif @facing == LEFT
      animate(@left_sprites)
    else
      raise "what direction are you facing?"
    end
  end

  def animate(sprite_sheet)
    step = @step_count % 3
    sprite_sheet[step].draw(@position.col*GameConfig::GAME_TILE_DIMENSIONS,@position.row*GameConfig::GAME_TILE_DIMENSIONS-GameConfig::PLAYER_TILE_OFFSET,1)
  end
end
