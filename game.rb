require 'hasu'
require 'pry'

Hasu.load './lib/GameConfig.rb'
Hasu.load './lib/Position.rb'
Hasu.load './lib/Tile.rb'
Hasu.load './lib/Board.rb'
Hasu.load './lib/Player.rb'
Hasu.load './lib/Spell.rb'


class Game < Hasu::Window

  @@frame_count = 0
  def self.frame_count
    @@frame_count
  end

  def initialize
    super(GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS)
  end

  def reset
    @game_state = "title"
    @title_image = Gosu::Image.new("./Images/Tiles/TitleScreen.png")
    @winning_player = nil
    self.caption = "Flip tiles to your color to reach your goal!"
    @top_right_position = Position.new(1,GameConfig::GAME_TILES_PER_SIDE-2)
    @bottom_left_position = Position.new(GameConfig::GAME_TILES_PER_SIDE - 2, 1)
    @bottom_right_position = Position.new(GameConfig::GAME_TILES_PER_SIDE-2, GameConfig::GAME_TILES_PER_SIDE - 2)
    @top_left_position = Position.new(1,1)
    @players = []
    #keybindings
    keybindings_1 = {
      up: Gosu::KbW,
      right: Gosu::KbD,
      down: Gosu::KbS,
      left: Gosu::KbA,
      right_shoot: Gosu::KbE,
      left_shoot: Gosu::KbQ
    }
    keybindings_2 = {
      up: Gosu::KbI,
      right: Gosu::KbL,
      down: Gosu::KbK,
      left: Gosu::KbJ,
      right_shoot: Gosu::KbO,
      left_shoot: Gosu::KbU
    }

    @board = Board.new(@top_left_position, @bottom_right_position)
    @players << Player.new("Player 1", @bottom_right_position, Tile::PLAYER_1_GOAL, './Images/Characters/warrior_f.png', keybindings_1, Tile::PLAYER_1_TILE)
    @players << Player.new("Player 2", @top_left_position, Tile::PLAYER_2_GOAL, './Images/Characters/healer_f.png', keybindings_2, Tile::PLAYER_2_TILE)
  end

  def update
    if @game_state = "title"
      #wait for KBenter
    elsif @winning_player
      #do nothing
    else
      @players.each do |player|
        player.update(@board.tiles)
        player.my_spells.each_with_index do |spell, index|
          this_tile = @board.tiles.find{|tile| tile.position == spell.position}
          if [Tile::WALL, Tile::PLAYER_1_GOAL, Tile::PLAYER_2_GOAL].include?(this_tile.tile_color)
            player.my_spells.delete_at(index)
          elsif spell.resulting_tile_type != this_tile.tile_color
            this_tile.change_color(spell.resulting_tile_type)
            player.my_spells.delete_at(index)
          else
            spell.position.go(spell.heading)
          end
        end
      end
    end
  end

  def draw
    if @game_state = "title"
      @title_image.draw(0,0,5)
    else
      @winning_player = @players.select{ |player| player.winning }[0]
      if @winning_player
        puts "#{@winning_player.player_name} wins!"
        #show credits
      else
        @board.draw
        @players.each{ |player| player.draw }
      end
      @@frame_count += 1
    end
  end
end

Game.run
