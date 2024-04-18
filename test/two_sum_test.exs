defmodule TwoSumTest do
  use ExUnit.Case
  doctest TwoSum

  test "no input" do
    assert TwoSum.run(:naive, [], 19) == :not_found
  end

  test "single number input" do
    assert TwoSum.run(:naive, [19], 19) == :not_found
    assert TwoSum.run(:naive, [12], 19) == :not_found
  end
end
