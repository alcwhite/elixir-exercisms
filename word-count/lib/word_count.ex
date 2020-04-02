defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence_list = String.split(Regex.replace(~r/[!@#$%^&*\(\)\{\}\[\]\|\\:;"'<,>.?\/~`=+_]/, String.downcase(sentence), " "), " ", trim: true)
    Enum.reduce(Enum.uniq(sentence_list), %{}, fn word, acc -> Map.put_new(acc, word, Enum.count(Enum.filter(sentence_list, fn x -> x == word end))) end)
  end
end
