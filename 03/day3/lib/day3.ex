defmodule Day3 do
  @moduledoc """
  Documentation for Day3.
  """

  @doc """
  Parse a claim

  ## Examples
  
      iex > Day3.parse_claim("#123 @ 3,2: 5x4")
      {123, 3, 2, 5, 4}
  """
  def parse_claim(input) do
    [id, left, right, width, height] = String.split(input, ["#", " @ ", ",", ": ", "x"], trim: true) |> Enum.map(&String.to_integer/1)
    {id, left, right, width, height}
  end

  @doc """
  Generate a Map of all the areas claimed, along with which id claimed them

  ## Examples
       iex > Day3.claim_map([{1, 1, 3, 4, 4}, {2, 3, 1, 4, 4}])
       %{
         {3, 1} => [2],
         {3, 2} => [2],
         {4, 1} => [2],
         {4, 2} => [2],
         {5, 1} => [2],
         {5, 2} => [2],
         {5, 3} => [2],
         {5, 4} => [2],
         {6, 1} => [2],
         {6, 2} => [2],
         {6, 3} => [2],
         {6, 4} => [2],
         {1, 3} => [1],
         {2, 3} => [1],
         {3, 3} => [1, 2],
         {4, 3} => [1, 2],
         {1, 4} => [1],
         {2, 4} => [1],
         {3, 4} => [1, 2],
         {4, 4} => [1, 2],
         {1, 5} => [1],
         {2, 5} => [1],
         {3, 5} => [1],
         {4, 5} => [1],
         {1, 6} => [1],
         {2, 6} => [1],
         {3, 6} => [1],
         {4, 6} => [1],
       }
  """
  def claim_map(parsed_claims) do
    parsed_claims
    |> Enum.reduce(%{}, fn {id, left, top, width, height}, map ->
      locations = for x <- (left+1)..(left+width),
                      y <- (top+1)..(top+height) do
        {x, y}
      end
      Enum.reduce(locations, map, fn(loc, map) -> Map.update(map,loc, [id], &([id | &1])) end)
    end)
  end

  @doc """
  Generate a Map of all the areas claimed, along with which id claimed them

  ## Examples
       iex > Day3.non_overlapping(
       %{
         {3, 1} => [2],
         {3, 2} => [2],
         {4, 1} => [2],
         {4, 2} => [2],
         {5, 1} => [2],
         {5, 2} => [2],
         {5, 3} => [2],
         {5, 4} => [2],
         {6, 1} => [2],
         {6, 2} => [2],
         {6, 3} => [2],
         {6, 4} => [2],
         {1, 3} => [1],
         {2, 3} => [1],
         {3, 3} => [1, 2],
         {4, 3} => [1, 2],
         {1, 4} => [1],
         {2, 4} => [1],
         {3, 4} => [1, 2],
         {4, 4} => [1, 2],
         {1, 5} => [1],
         {2, 5} => [1],
         {3, 5} => [1],
         {4, 5} => [1],
         {1, 6} => [1],
         {2, 6} => [1],
         {3, 6} => [1],
         {4, 6} => [1],
         {5, 6} => [3],
         {5, 7} => [3],
       })
       #MapSet<[3]>
  """
  def non_overlapping(claim_map) do
    claim_map
    |> Enum.reduce({MapSet.new, MapSet.new}, &Day3.check_overlap/2)
    |> elem(0)
  end

  def check_overlap({_loc, [x]}, {candidates, seen}) do
    has_seen = MapSet.member?(seen, x)

    if has_seen do
      {candidates, MapSet.put(seen, x)}
    else
      {MapSet.put(candidates, x), MapSet.put(seen, x)}
    end
  end

  def check_overlap({_loc, dupes}, {candidates, seen}) do
    pot_set = MapSet.new(dupes)

    {MapSet.difference(candidates, pot_set), MapSet.union(seen, pot_set)}
  end
end
