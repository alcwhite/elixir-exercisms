defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    codons = Enum.chunk_every(String.to_charlist(rna), 3)
    protein_list = Enum.map(codons, fn codon -> @proteins[List.to_string(codon)] end)
    stop_index = if Enum.member?(protein_list, "STOP") do
      Enum.find_index(protein_list, fn protein -> protein === "STOP" end) - 1
    else
      Enum.count(protein_list)
    end
    result = unless Enum.member?(protein_list, nil) do
      {:ok, Enum.slice(protein_list, 0..stop_index)}
    else
      {:error, "invalid RNA"}
    end
    result
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    protein = @proteins[codon]
    result = unless !protein do
      {:ok, protein}
    else
      {:error, "invalid codon"}
    end
    result
  end
end
