defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    s = unless number === 1 do "s" end
    less_number = if number !== 1 do
      number - 1
    else
      "no more"
    end
    other_s = unless less_number === 1 do "s" end
    take = if number > 1 do
      "one"
    else 
      "it"
    end
    unless number === 0 do
      "#{number} bottle#{s} of beer on the wall, #{number} bottle#{s} of beer.\nTake #{take} down and pass it around, #{less_number} bottle#{other_s} of beer on the wall.\n"
    else
      "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  end

  def lyrics_range({number, last, precedingLyrics}) when number !== last do
    precedingLyrics = unless precedingLyrics === "" do 
      precedingLyrics <> "\n" 
    else precedingLyrics 
    end
      lyrics_range({number - 1, last, precedingLyrics <> verse(number)})
  end
  def lyrics_range({number, last, precedingLyrics}) when number === last do
    precedingLyrics = unless precedingLyrics === "" do 
      precedingLyrics <> "\n" 
    else precedingLyrics 
    end
    precedingLyrics <> verse(number)
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    first..last = range
    lyrics_range({first, last, ""})
  end
  @spec lyrics() :: String.t()
  def lyrics() do
    first..last = 99..0
    lyrics_range({first, last, ""})
  end
end
