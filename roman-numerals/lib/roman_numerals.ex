defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """

  def check_number({number, result}) when number >= 1000 do
    check_number({number - 1000, result <> "M"})
  end
  @spec check_number({number, any}) :: any
  def check_number({number, result}) when number >= 900 do
    check_number({number - 900, result <> "CM"})
  end
  def check_number({number, result}) when number >= 500 do
    check_number({number - 500, result <> "D"})
  end
  def check_number({number, result}) when number >= 400 do
    check_number({number - 400, result <> "CD"})
  end
  def check_number({number, result}) when number >= 100 do
    check_number({number - 100, result <> "C"})
  end
  def check_number({number, result}) when number >= 90 do
    check_number({number - 90, result <> "XC"})
  end
  def check_number({number, result}) when number >= 50 do
    check_number({number - 50, result <> "L"})
  end
  def check_number({number, result}) when number >= 40 do
    check_number({number - 40, result <> "XL"})
  end
  def check_number({number, result}) when number >= 10 do
    check_number({number - 10, result <> "X"})
  end
  def check_number({number, result}) when number == 9 do
    check_number({number - 9, result <> "IX"})
  end
  def check_number({number, result}) when number >= 5 do
    check_number({number - 5, result <> "V"})
  end
  def check_number({number, result}) when number == 4 do
    check_number({number - 4, result <> "IV"})
  end
  def check_number({number, result}) when number >= 1 do
    check_number({number - 1, result <> "I"})
  end
  def check_number({number, result}) when number == 0 do
    result
  end

  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    {number, result} = {number, ""}
    check_number({number, result})
  end
end
