defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}

  test "starts a player child process" do
    robot = %Robot{north: 0, east: 0, facing: :north}
    {:ok, player} = PlayerSupervisor.start_child(robot, "TEST-ROBOT-1")
    [{registered_player, _}] = Registry.lookup(ToyRobot.Game.PlayerRegistry, "TEST-ROBOT-1")
    assert registered_player == player
  end

  test "starts a registry service" do
    registry = Process.whereis(ToyRobot.Game.PlayerRegistry)
    assert registry
  end

  test "moves a robot forward" do
    robot = %Robot{north: 0, east: 0, facing: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot, "TEST-ROBOT-2")
    assert :ok = PlayerSupervisor.move("TEST-ROBOT-2")
  end

  test "reports a robots locations" do
    robot = %Robot{north: 0, east: 0, facing: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot, "TEST-ROBOT-3")
    %{north: north} = PlayerSupervisor.report("TEST-ROBOT-3")

    assert north == 0
  end
end
