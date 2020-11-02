defmodule Apigetmore do
  def maioresufcsv do
  #usando a lib HTTPoison para carregar o csv direto do link que foi sugerido
  uf = HTTPoison.get!("https://gist.githubusercontent.com/chronossc/1a010c6968528066acbee6bc03c2aefa/raw/bfbd1f86ed026c935e6b4df365caf0cd054ce947/cities.csv").body
  #tratando as linhas do csv, para um padrão mais legível
    |> String.split("\n")
    #partindo as strings reescrevendo as siglas sem parênteses (através do range -3..-2 recebendo as cidades por uf)
    |> Enum.map(fn cidades-> String.slice(cidades, -3..-2) end)
    #recursão utilizada para implementar o contador, atualizando com o map.merge (como em uma hashtable) no mapa%{}
    |> Enum.reduce( %{}, fn n, acc ->
        if acc[n] do
          count = acc[n] + 1
          #atualizando os valores
          Map.merge(acc, %{n => count})
        else
          Map.merge(acc, %{n => 1})
        end
      end)
    #aqui o novo enumerável sorteando os elementos em posição decresente...3,2,1 - se fosse crescente seria :asc
    |> Enum.sort_by(&elem(&1, 1), :desc)

      maioruf = Enum.join(Tuple.to_list(Enum.at(uf, 0)), "-> ")
      seguf = Enum.join(Tuple.to_list(Enum.at(uf, 1)), "-> ")
      tercuf = Enum.join(Tuple.to_list(Enum.at(uf, 2)), "-> ")

    IO.puts("#{maioruf}, #{seguf}, #{tercuf}")
  end
end
