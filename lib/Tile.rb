class Tile
  WALL = 0
  GREY = 12
  PLAYER_1_TILE = 14
  PLAYER_2_TILE = 15
  PLAYER_1_GOAL = 4
  PLAYER_2_GOAL = 5

  attr_accessor :tile_color, :position

  @@board_sprites = Gosu::Image.load_tiles('./Images/Tiles/Tiles.png', GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILE_DIMENSIONS)
  @@p1_goal_tile_ani = Animation.new('./Images/Tiles/Tiles.png', GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILE_DIMENSIONS, 5, [4,6,8])
  @@p2_goal_tile_ani =Animation.new('./Images/Tiles/Tiles.png', GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILE_DIMENSIONS, 5, [5,7,9])

  def initialize(position)
    @position = position
    @tile_color = GREY

  end

  def is_a_wall?(wall_locations)
    wall_locations.include?(@position.col) || wall_locations.include?(@position.row)
  end

  def change_color(target_color)
    @tile_color = target_color
  end

  def update
    @@p1_goal_tile_ani.update
    @@p2_goal_tile_ani.update
  end

  def draw
    if @tile_color == PLAYER_1_GOAL
      @@p1_goal_tile_ani.draw(@position.col*GameConfig::GAME_TILE_DIMENSIONS,@position.row*GameConfig::GAME_TILE_DIMENSIONS,0)
    elsif @tile_color == PLAYER_2_GOAL
      @@p2_goal_tile_ani.draw(@position.col*GameConfig::GAME_TILE_DIMENSIONS,@position.row*GameConfig::GAME_TILE_DIMENSIONS,0)
    else
      @@board_sprites[@tile_color].draw(@position.col*GameConfig::GAME_TILE_DIMENSIONS,@position.row*GameConfig::GAME_TILE_DIMENSIONS,0)
    end
  end
end
