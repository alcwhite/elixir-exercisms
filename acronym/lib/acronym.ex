defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string = Regex.replace(~r/^'|[-_:;"!@#$%^&*(){}\[\],.\/\\|<>=+`~]/, string, " ")
    string = Regex.replace(~r/(?<![A-Z])[A-Z]/, string, " \\0")
    string_list = String.split(string, " ")
    initial_list = Enum.map(string_list, fn x -> String.at(x, 0) end)
    String.upcase(Enum.join(initial_list))
  end
end
