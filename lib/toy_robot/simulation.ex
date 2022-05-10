defmodule ToyRobot.Simulation do
  alias ToyRobot.{Robot, Simulation, Table}
  defstruct [:table, :robot]

  @doc """
  Simulates placing a robot on a table.


  ## Examples

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> Simulation.place(table, %{north: 0, east: 0, facing: :north})
      {
        :ok,
        %Simulation{
          table: table,
          robot: %Robot{north: 0, east: 0, facing: :north}
        }
      }

  When the robot is placed in an invalid position:

      iex> alias ToyRobot.{Table, Simulation}
      [ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> Simulation.place(table, %{north: 6, east: 0, facing: :north})
      {:error, :invalid_placement}
  """
  def place(table, placement) do
    maybe_place(table, placement, Table.valid_position?(table, placement))
  end

  defp maybe_place(table, placement, true) do
    {
      :ok,
      %Simulation{
        table: table,
        robot: struct(Robot, placement)
      }
    }
  end

  defp maybe_place(_table, _placement, false), do: {:error, :invalid_placement}
end
