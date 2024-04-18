defmodule TwoSumNaiveTest do
  use ExUnit.Case, async: true

  alias TwoSum.Naive

  test "no input" do
    assert Naive.run([], 19) == :not_found
  end

  test "basic working input in first positions" do
    assert Naive.run([8, 16, 1, 55], 24) == {{0, 1}, {8, 16}}
  end

  test "working inputs in different positions" do
    assert Naive.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 50) == {{4, 7}, {5, 45}}
    assert Naive.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 20) == {{0, 10}, {8, 12}}
    assert Naive.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 7) == {{2, 5}, {1, 6}}
  end
end
