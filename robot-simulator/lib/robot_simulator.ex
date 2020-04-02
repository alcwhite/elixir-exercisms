defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @directions [:north, :south, :east, :west]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0}) do
    result = cond do
      !Enum.member?(@directions, direction) -> {:error, "invalid direction"}
      !is_tuple(position) or tuple_size(position) !== 2 or !is_integer(elem(position, 0)) or !is_integer(elem(position, 1)) -> {:error, "invalid position"}
      true -> %{direction: direction, position: position}
    end
    result
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  def turn_right(robot) do
    direction = case robot.direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
    %{direction: direction, position: robot.position}
  end
  def turn_left(robot) do
    direction = case robot.direction do
      :north -> :west
      :east -> :north
      :south -> :east
      :west -> :south
    end
    %{direction: direction, position: robot.position}
  end
  def take_step(robot) do
    {former_x, former_y} = robot.position
    position = case robot.direction do
      :north -> {former_x, former_y + 1}
      :east -> {former_x + 1, former_y}
      :south -> {former_x, former_y - 1}
      :west -> {former_x - 1, former_y}
    end
    %{direction: robot.direction, position: position}
  end
  def complete_move({robot, instructions, instruction_length, index}) do
    robot = case String.at(instructions, index) do
      "R" -> turn_right(robot)
      "L" -> turn_left(robot)
      "A" -> take_step(robot)
    end
    {robot, instructions, instruction_length, index + 1}
  end
  def move({robot, instructions, instruction_length, index}) when index + 1 < instruction_length do
     move(complete_move({robot, instructions, instruction_length, index}))
  end
  def move({robot, instructions, instruction_length, index}) when index + 1 == instruction_length do
    {robot, _instructions, _instruction_length, _index} = complete_move({robot, instructions, instruction_length, index})
    robot
  end
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    cond do
      !Enum.all?(String.graphemes(instructions), fn x -> String.match?(x, ~r/[LRA]/) end) -> {:error, "invalid instruction"}
      true -> move({robot, instructions, String.length(instructions), 0})
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
