defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  def calculate({input, stops}) when input > 1 do
    new_input = cond do
      rem(input, 2) == 1 -> 3 * input + 1
      rem(input, 2) == 0 -> div(input, 2)
    end
    calculate({new_input, stops + 1})
  end
  def calculate({input, stops}) when input == 1 do
    stops
  end

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) do
    cond do
      !is_integer(input) or input <= 0 -> raise(FunctionClauseError)
      input == 1 -> 0
      true -> calculate({input, 0})
    end
  end
end
