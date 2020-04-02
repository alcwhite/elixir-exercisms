defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    letters = String.graphemes(Regex.replace(~r/[- ]/, sentence, ""))
    Enum.uniq(letters) == letters
  end
end
