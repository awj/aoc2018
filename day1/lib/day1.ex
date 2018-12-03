defmodule Day1 do
  def frequency(list, initial \\ 0) do
    Enum.reduce(list, initial, fn x, acc -> acc + x end)
  end

  def repeat_check(changes, freq \\ 0, seen \\ %{}) do
    case check(changes, freq, seen) do
      {:uniq, freq, seen} -> repeat_check(changes, freq, seen)
      {:dup, new_freq} -> new_freq
    end
  end

  def evaluate(freq, change, seen) do
    new_freq = freq + change
    case Map.get(seen, new_freq) do
      1 -> { :dup, new_freq }
      _ -> { :uniq, new_freq }
    end
  end

  def check([], freq, seen) do
    {:uniq, freq, seen}
  end

  def check([change | rest], freq, seen) do
    case evaluate(freq, change, seen) do
      {:dup, new_freq } -> {:dup, new_freq }
      {:uniq, new_freq } -> check(rest, new_freq, Map.put(seen, new_freq, 1))
    end
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn(x) -> elem(x,0) end)
  end
end
