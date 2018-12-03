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
end
