require 'gosu'
require './lib/GameConfig.rb'
require './lib/Position.rb'
require './lib/Animation.rb'
require './lib/Tile.rb'
require './lib/Board.rb'
require './lib/Player.rb'
require './lib/Spell.rb'

class Game < Gosu::Window

  @@frame_count = 0
  def self.frame_count
    @@frame_count
  end

  def initialize
    super(GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS, GameConfig::GAME_TILES_PER_SIDE * GameConfig::GAME_TILE_DIMENSIONS)
    reset
  end

  def reset
    @game_state = "title"
    @title_ani = Animation.new("./Images/Tiles/TitleAnimated.png", 525, 268, 2)
    @frame_ani = Animation.new("./Images/Tiles/TitleScreenFrame.png", 800, 800, 2)
    @controls_ani = Animation.new("./Images/Tiles/ControlsLarge.png", 640, 192, 2)
    @p1_credits_image = Gosu::Image.new("./Images/Tiles/Player1Credits.png")
    @p2_credits_image = Gosu::Image.new("./Images/Tiles/Player2Credits.png")
    @gameplay_song = Gosu::Song.new("./Audio/HHavok-intro-loop.wav")
    @gameplay_song.play(true)
    @gameplay_song.pause()
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
    @players << Player.new("Player 1", @bottom_right_position, Tile::PLAYER_1_GOAL, './Images/Characters/warrior_f.png', keybindings_1, Tile::PLAYER_1_TILE, "./Audio/Move.wav", 0.5)
    @players << Player.new("Player 2", @top_left_position, Tile::PLAYER_2_GOAL, './Images/Characters/healer_f.png', keybindings_2, Tile::PLAYER_2_TILE, "./Audio/Move2.wav", 1)
  end

  def update
    if @game_state == "title"
      @title_ani.update
      @frame_ani.update
      @controls_ani.update
      if Gosu::button_down?(Gosu::KbReturn) || Gosu::button_down?(Gosu::KbEnter)
        unless @gameplay_song.playing?
          @gameplay_song.play(true)
        end
        @game_state = "playing"
      end
    elsif @winning_player
      @gameplay_song.pause
      if Gosu::button_down?(Gosu::KbB)
        reset
      end
    else
      @board.update
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
    if @game_state == "title"
      @title_ani.draw(136, 115, 6)
      @frame_ani.draw(0, 0, 4)
      @controls_ani.draw(70, 600, 5)
    else
      @winning_player = @players.select{ |player| player.winning }[0]
      if @winning_player
        if @winning_player.player_name == "Player 1"
          @p1_credits_image.draw(0,0,5)
        elsif @winning_player.player_name == "Player 2"
          @p2_credits_image.draw(0,0,5)
        end
      else
        @board.draw
        @players.each{ |player| player.draw }
      end
    end
    @@frame_count += 1
  end
end

Game.new.show
