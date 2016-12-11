require 'pry'

class Player
  MOVE_LIMIT = 10

  def initialize(starting_position, goal_position, sprite_sheet_path, keybindings, game)
    @position = starting_position
    @goal_position = goal_position
    @my_sprites = Gosu::Image.load_tiles(sprite_sheet_path, GameConfig::PLAYER_TILE_WIDTH, GameConfig::PLAYER_TILE_HEIGHT)
    @keybindings = keybindings
    @game = game
    @next_move_in = 0
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
        @position.row -= 1
        movement_cooldown
      elsif Gosu::button_down? @keybindings[:down]
        @position.row += 1
        movement_cooldown
      elsif Gosu::button_down? @keybindings[:left]
        @position.col -= 1
        movement_cooldown
      elsif Gosu::button_down? @keybindings[:right]
        @position.col += 1
        movement_cooldown
      end
    end
  end

  def draw
    @my_sprites[7].draw(@position.col*GameConfig::GAME_TILE_DIMENSIONS,@position.row*GameConfig::GAME_TILE_DIMENSIONS-GameConfig::PLAYER_TILE_OFFSET,1)
  end
end
