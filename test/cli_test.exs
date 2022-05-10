defmodule ToyRobot.CLITest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  test "handles commands and reports successfully" do
    commands_path = Path.expand("test/fixtures/commands.txt", File.cwd!())

    output =
      capture_io(fn ->
        ToyRobot.CLI.main([commands_path])
      end)

    expected_output = """
    The robot is at (0, 4) and is facing NORTH
    """

    assert String.trim(output) == String.trim(expected_output)
  end

  test "provides usage instructions if no arguments specified" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main([])
      end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "provides usage instructions if too many arguments specified" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main(["commands.txt", "commands_two.txt"])
      end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "shows an error message if the file does not exist" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main(["does_not_exist.txt"])
      end)

    assert output |> String.trim() == "The file does_not_exist.txt does not exist"
  end
end
