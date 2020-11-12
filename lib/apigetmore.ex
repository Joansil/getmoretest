defmodule Apigetmore do
  @moduledoc """
    Este módulo trata-se de um teste de api para capturar um arquivo CSV hospedado, que contem os
    estados e municípios brasileiros, e retorna os 3 estados que possuem mais municípios.
  """
  @doc """
    Foi utilizada a lib HTTPoison para capturar o CSV direto do link que foi sugerido, e dar um
    GET no body do CSV, depois os dados foram tratados para um padrão mais legível, partindo as strings
    reescrevendo-as em siglas sem os parentêses`String.slice`. Logo após utilizada recursão para
    filtrar e implementar o contador de cidades armazenadas no `map` e atualizar os valores da estrutura
    E por fim a informação foi passada em ordem decrescente.
  """
  def maioresufcsv do
    uf = HTTPoison.get!("https://gist.githubusercontent.com/chronossc/1a010c6968528066acbee6bc03c2aefa/raw/bfbd1f86ed026c935e6b4df365caf0cd054ce947/cities.csv").body
    |> String.split("\n")
    |> Enum.map(fn cidades-> String.slice(cidades, -3..-2) end)
    |> Enum.reduce( %{}, fn n, acc ->
        if acc[n] do
          count = acc[n] + 1
          #atualizando os valores
          Map.merge(acc, %{n => count})
        else
          Map.merge(acc, %{n => 1})
        end
      end)
    |> Enum.sort_by(&elem(&1, 1), :desc)

      maioruf = Enum.join(Tuple.to_list(Enum.at(uf, 0)), "-> ")
      seguf = Enum.join(Tuple.to_list(Enum.at(uf, 1)), "-> ")
      tercuf = Enum.join(Tuple.to_list(Enum.at(uf, 2)), "-> ")

    IO.puts("#{maioruf}, #{seguf}, #{tercuf}")
  end
end
