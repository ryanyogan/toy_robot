defmodule ToyRobot.Table do
  defstruct [:north_boundary, :east_boundary]
  alias ToyRobot.Table

  alias ToyRobot.Robot

  @doc """
  Determines if a position would within the table's boundaries.

  ## Examples

      iex> alias ToyRobot.Table
      ToyRobot.Table
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> table |> Table.valid_position?(%{north: 4, east: 0})
      true
      iex> table |> Table.valid_position?(%{north: 0, east: 0})
      true
      iex> table |> Table.valid_position?(%{north: 6, east: 0})
      false
  """
  def valid_position?(
        %Table{north_boundary: north_boundary, east_boundary: east_boundary},
        %{north: north, east: east}
      ) do
    north in 0..north_boundary && east in 0..east_boundary
  end
end
