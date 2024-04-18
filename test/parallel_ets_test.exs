defmodule TwoSumParallelEtsTest do
  use ExUnit.Case, async: true

  alias TwoSum.ParallelEts

  test "basic working input in first positions" do
    assert ParallelEts.run([8, 16, 1, 55], 24, table_name: :t00) == {{0, 1}, {8, 16}}
  end

  test "working inputs in different positions" do
    assert ParallelEts.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 50, table_name: :t10) ==
             {{4, 7}, {5, 45}}

    assert ParallelEts.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 20, table_name: :t11) in [
             {{0, 10}, {8, 12}},
             {{6, 6}, {10, 10}}
           ]

    assert ParallelEts.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 12], 7, table_name: :t12) ==
             {{2, 5}, {1, 6}}

    assert ParallelEts.run([8, 16, 1, 55, 5, 6, 10, 45, 67, 33, 200], 233, table_name: :t13) ==
             {{9, 10}, {33, 200}}
  end

  test "non working input" do
    assert ParallelEts.run([8, 16, 1, 55], 99, table_name: :t20) == :not_found
  end
end
