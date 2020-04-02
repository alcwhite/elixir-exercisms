defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  def surrounding_cell(split_board, current_row, current_column) do
    row_count = Enum.count(split_board)
    column_count = Enum.count(Enum.at(split_board, 0))
    Enum.at(Enum.at(split_board, correct_index(current_row, row_count), []), correct_index(current_column, column_count), "0")
  end
  def correct_index(current_index, enum_length) do
    if current_index < 0 do
      enum_length
    else
      current_index
    end
  end
  @spec annotate([String.t()]) :: [String.t()]
  def annotate(board) do
    split_board = Enum.map(board, fn row -> String.codepoints(row) end)
    indexed_board = Enum.with_index(Enum.map(split_board, fn row -> Enum.with_index(row) end))
    correct_cells = Enum.map(indexed_board, fn {row, i} -> Enum.map(row, fn {cell, j} ->
      if cell === " " do
        surrounding_cells = [surrounding_cell(split_board, i - 1, j - 1), surrounding_cell(split_board, i - 1, j), surrounding_cell(split_board, i - 1, j + 1), surrounding_cell(split_board, i, j - 1), surrounding_cell(split_board, i, j + 1), surrounding_cell(split_board, i + 1, j - 1), surrounding_cell(split_board, i + 1, j), surrounding_cell(split_board, i + 1, j + 1)]
        Enum.reduce(surrounding_cells, 0, fn cell, acc -> if cell === "*" do acc + 1 else acc end end)
      else
        cell
      end
    end) end)
    final_board = Enum.map(correct_cells, fn row -> Enum.join(row) end)
    Enum.map(final_board, fn row -> String.replace(row, "0", " ") end)
  end
end
