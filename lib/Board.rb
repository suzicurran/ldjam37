class Board

  def initialize(player_1_goal_position, player_2_goal_position)
    @p1_goal_position = player_1_goal_position
    @p2_goal_position = player_2_goal_position
    wall_locations = [0, (GameConfig::GAME_TILES_PER_SIDE - 1)]

    @tiles = []
    GameConfig::GAME_TILES_PER_SIDE.times do |index_for_column|
      GameConfig::GAME_TILES_PER_SIDE.times do |index_for_row|
        this_tile = Tile.new(index_for_column, index_for_row)
        if this_tile.is_a_wall?(wall_locations)
          this_tile.tile_color = Tile::WALL
        elsif this_tile.is_position?(@p1_goal_position)
          this_tile.tile_color = Tile::PLAYER_2_GOAL
        elsif this_tile.is_position?(@p2_goal_position)
          this_tile.tile_color = Tile::PLAYER_1_GOAL
        end

        if this_tile
          @tiles << this_tile
        end
      end
    end
  end

  def draw
    @tiles.each do |tile|
      tile.draw
    end
  end
end
