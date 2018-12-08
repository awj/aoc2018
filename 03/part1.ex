defmodule Part1 do
  def overlapping_claims(input) do
    parse_claims(input)
    |> Stream.reduce(%{}, &build_claim_map/2)
  end

  def build_claim_map(claim, claim_map) do
    
  end

  def parse_claims(input) do
    String.trim(input)
    |> String.split("\n")
    |> Stream.map(&digest_claim/1)
  end

  def digest_claim(line) do
    parts = String.split(line, " ")
    id = Enum.at(parts, 0)
    IO.inspect(parts)
    loc = String.split(Enum.at(parts, 2), ",")
    dist = String.split(Enum.at(parts, 3), "x")
    x = Enum.at(loc, 0)
    y = Enum.at(String.split(Enum.at(loc, 1), ":"), 0)
    length = Enum.at(dist, 0)
    width = Enum.at(dist,1)

    loc = { String.to_integer(x), String.to_integer(y) }
    dist = { String.to_integer(length), String.to_integer(width) }
    {id, loc, dist }
  end

  def all_pairs({x, y}, {length, width}) do
    for xd <- 0..length, yd <- 0..width do
      {x + xd, y + yd}
    end
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Part1Test do
      use ExUnit.Case

      import Part1

      test "overlapping_claims" do
        assert Part1.overlapping_claims("""
#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2
""") == 4
      end
    end

  _ -> true
end
