defmodule ToyRobot.Game.Player do
  use GenServer
  alias ToyRobot.{Simulation, Robot}

  def start_link(table: table, position: position, name: name) do
    GenServer.start_link(
      __MODULE__,
      [table: table, position: position],
      name: process_name(name)
    )
  end

  def move(player) do
    GenServer.cast(player, :move)
  end

  def report(player) do
    GenServer.call(player, :report)
  end

  def process_name(name) do
    {:via, Registry, {ToyRobot.Game.PlayerRegistry, name}}
  end

  @impl true
  def init(table: table, position: position) do
    simulation = %Simulation{
      table: table,
      robot: struct(Robot, position)
    }

    {:ok, simulation}
  end

  @impl true
  def handle_call(:report, _from, simulation) do
    {:reply, Simulation.report(simulation), simulation}
  end

  @impl true
  def handle_cast(:move, simulation) do
    {:ok, new_simulation} = simulation |> Simulation.move()
    {:noreply, new_simulation}
  end
end
