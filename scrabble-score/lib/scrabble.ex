defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    letters = %{
      ?A => 1, ?E => 1, ?I => 1, ?O => 1, ?U => 1, ?L => 1, ?N => 1, ?R => 1, ?S => 1, ?T => 1,
      ?D => 2, ?G => 2,
      ?B => 3, ?C => 3, ?M => 3, ?P => 3,
      ?F => 4, ?H => 4, ?V => 4, ?W => 4, ?Y => 4,
      ?K => 5,
      ?J => 8, ?X => 8,
      ?Q => 10, ?Z => 10}
    word_letters = Enum.filter(to_charlist(String.upcase(word)), fn x -> Map.has_key?(letters, x) end)
    unless Enum.empty?(word_letters) do
      Enum.reduce(word_letters, 0, fn x, acc -> letters[x] + acc end)
    else
      0
    end
  end
  @spec score(String.t(), atom) :: non_neg_integer
  def score(word, special_word_type) do
    case special_word_type do
      :double -> score(word) * 2
      :triple -> score(word) * 3
    end
  end
  @spec score(String.t(), atom, String.t()) :: non_neg_integer
  def score(word, special_letter_type, letter) do
    case special_letter_type do
      :double -> score(word <> letter)
      :triple -> score(word <> letter <> letter)
    end
  end
  @spec score(String.t(), atom, atom, String.t()) :: non_neg_integer
  def score(word, special_word_type, special_letter_type, letter) do
    case special_word_type do
      :double -> score(word, special_letter_type, letter) * 2
      :triple -> score(word, special_letter_type, letter) * 3
    end
  end
end
