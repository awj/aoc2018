defmodule Day2 do
  def counts(letters) do
    letters
    |> Enum.map(fn(x) -> Enum.count(letters, fn(y) -> y == x end) end)
  end

  def check(letters) do
    vals = counts(letters)
    vals
    |> Enum.reduce(%{two: false, three: false}, &find/2)
  end

  def find(x, state) do
    case x do
      2 -> Map.put(state, :two, true)
      3 -> Map.put(state, :three, true)
      _ -> state
    end
  end

  def similarity(a, b) do
    Enum.zip(a,b)
    |> Enum.count(fn({x,y}) -> x != y end)
  end

  def compare([]) do
    :far
  end

  def compare([head | inputs]) do
    case most_similar(head, inputs) do
      {:close, other } -> {head, other}
      :far -> compare(inputs)
    end
  end

  def most_similar(check, inputs) do
    {count, _, result} = inputs
    |> Enum.reduce({10000, check, nil}, &digest_similarity/2)

    case count do
      1 -> {:close, result}
      _ -> :far
    end
  end

  def digest_similarity(x, {count, check, old}) do
    similarity = Day2.similarity(check, x)

    cond do
      similarity < count -> {similarity, check, x}
      true -> {count, check, old}
    end
  end
end
