defmodule TwoSumOnePassMapTest do
  use ExUnit.Case, async: true

  alias TwoSum.OnePassMap

  test "basic working input in first positions" do
    assert OnePassMap.run([8, 16, 1, 55], 24) == {{0, 1}, {8, 16}}
  end

  test "working inputs in different positions" do
    assert OnePassMap.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 50) == {{4, 7}, {5, 45}}
    assert OnePassMap.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 20) == {{0, 10}, {8, 12}}
    assert OnePassMap.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 7) == {{2, 5}, {1, 6}}
    assert OnePassMap.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 200], 233) == {{9, 10}, {33, 200}}
  end

  test "non working input" do
    assert OnePassMap.run([8, 16, 1, 55], 99) == :not_found
  end
end
