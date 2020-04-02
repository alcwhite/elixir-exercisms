defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    Enum.each(opts, fn {color, coords} ->
      invalid_color(color)
      invalid_space(coords) end)
    if Keyword.keys(opts) == [:white, :black] or Keyword.keys(opts) == [:black, :white] do
      same_space(Keyword.get(opts, :white), Keyword.get(opts, :black))
    end
    Enum.reduce(opts, %Queens{}, fn {k, v}, acc -> Map.put(acc, k, v) end)
  end

  @colors [:white, :black]
  defp invalid_color(color) do
    if !Enum.member?(@colors, color) do
      raise ArgumentError
    end
  end
  defp invalid_space({x, y}) do
    if x < 0 or y < 0 or x >= 8 or y >= 8 do
      raise ArgumentError
    end
  end
  defp same_space({x1, y1}, {x2, y2}) do
    if x1 == x2 and y1 == y2 do
      raise ArgumentError
    end
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    row = Enum.map(1..8, fn _ -> "_" end)
    board = Enum.map(1..8, fn _ -> row end)
    board_with_white = if queens.white do
      insert_queen(queens.white, "W", board)
    else
      board
    end
    board_with_both = if queens.black do
      insert_queen(queens.black, "B", board_with_white)
    else
      board_with_white
    end
    joined_rows = Enum.map(board_with_both, fn row -> Enum.join(row, " ") end)
    Enum.join(joined_rows, "\n")
  end

  defp insert_queen(coords, symbol, board) do
    {x, y} = coords
    Enum.map(Enum.with_index(board), fn {row, i} ->
      if i == x do
        Enum.map(Enum.with_index(row), fn {box, j} ->
          if j == y do
            symbol
          else
            box
          end
        end)
      else
        row
      end
    end)
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    queen_map = Map.from_struct(queens)
    unless !Map.get(queen_map, :black) or !Map.get(queen_map, :white) do
      attacks?(queens)
    else
      false
    end
  end

  defp same_column?(queens) do
    elem(queens.white, 1) == elem(queens.black, 1)
  end
  defp same_row?(queens) do
    elem(queens.white, 0) == elem(queens.black, 0)
  end
  defp same_diagonal?(queens) do
    {xw, yw} = queens.white
    {xb, yb} = queens.black
    abs(xw - xb) == abs(yw - yb)
  end
  defp attacks?(queens) do
    if  (same_column?(queens) or same_row?(queens) or same_diagonal?(queens)) do
      true
    else
      false
    end
  end
end
