require 'pry'

class Player
  MOVE_LIMIT = 10

  UP = 0
  RIGHT = 1
  DOWN = 2
  LEFT = 3

  def initialize(starting_position, goal_position, sprite_sheet_path, keybindings, game)
    @position = starting_position
    @goal_position = goal_position
    @my_sprites = Gosu::Image.load_tiles(sprite_sheet_path, GameConfig::PLAYER_TILE_WIDTH, GameConfig::PLAYER_TILE_HEIGHT)
    @up_sprites = @my_sprites[0,3]
    @right_sprites = @my_sprites[3,3]
    @down_sprites = @my_sprites[6,3]
    @left_sprites = @my_sprites[9,3]
    @keybindings = keybindings
    @game = game
    @next_move_in = 0
    @facing = DOWN
    @step_count = 0
  end

  def update
    move
  end

  def self.starting_player_data
    return @@player_data
  end

  def wins?
    @position == @goal_position
  end

  def movement_cooldown
    @next_move_in = (@game.frame_count + 15)
  end

  def move
    if @game.frame_count >= @next_move_in
      if Gosu::button_down? @keybindings[:up]
        @facing = UP
        @position.row -= 1
        movement_cooldown
        @step_count += 1
      elsif Gosu::button_down? @keybindings[:down]
        @facing = DOWN
        @position.row += 1
        movement_cooldown
        @step_count += 1
      elsif Gosu::button_down? @keybindings[:left]
        @facing = LEFT
        @position.col -= 1
        movement_cooldown
        @step_count += 1
      elsif Gosu::button_down? @keybindings[:right]
        @facing = RIGHT
        @position.col += 1
        movement_cooldown
        @step_count += 1
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
