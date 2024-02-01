defmodule GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "start the game state" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "João"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
          },
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "João"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
          },
        turn: :player
      }

      assert expected_response == Game.info()

      new_info = %{
        status: :started,
        player: %Player{
          life: 85,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "João"
        },
        computer: %Player{
          life: 50,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
          },
        turn: :player
      }

      Game.update(new_info)

      expected_response = %{new_info | turn: :computer, status: :continue}

      assert expected_response == Game.info()

    end
  end

  describe "player/0" do
    test "returns the player" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_result = %Player{life: 100, moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco}, name: "João"}

      assert expected_result == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the player" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      assert :player == Game.turn()
    end
  end

  describe "fetch_player/0" do
    test "returns the player" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_result = %Player{life: 100, moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco}, name: "João"}

      assert expected_result == Game.fetch_player(:player)
    end
  end

end
