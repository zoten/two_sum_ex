defmodule Seed do
  @rnd_range 1..1000

  @spec create(len :: integer()) ::
          {seeds :: list(integer()), existing :: integer(), non_existing :: integer()}
  def create(len) do
    :rand.seed(:exsss, {1, 2, 3})

    lst =
      0..len
      |> Enum.map(fn _ -> Enum.random(@rnd_range) end)

    existing = lst |> Enum.take_random(2) |> Enum.sum()
    non_existing = Enum.sum(lst) + 1

    {lst, existing, non_existing}
  end
end

input_mini = Seed.create(10)
input_small = Seed.create(100)
input_medium = Seed.create(1000)
input_large = Seed.create(10000)
input_xl = Seed.create(100_000)
input_xxl = Seed.create(1_000_000)
input_xxxl = Seed.create(10_000_000)

Benchee.run(
  %{
    "naive.exist" => fn {lst, existing, _non_existing} -> TwoSum.Naive.run(lst, existing) end,
    "one_pass_map.exist" => fn {lst, existing, _non_existing} ->
      TwoSum.OnePassMap.run(lst, existing)
    end,
    "parallel_ets.exist.10" => fn {lst, existing, _non_existing} ->
      TwoSum.ParallelEts.run(lst, existing, table_name: :random, max_concurrency: 10)
    end,
    "parallel_ets.exist.100" => fn {lst, existing, _non_existing} ->
      TwoSum.ParallelEts.run(lst, existing, table_name: :random, max_concurrency: 100)
    end,
    "parallel_ets.exist.1000" => fn {lst, existing, _non_existing} ->
      TwoSum.ParallelEts.run(lst, existing, table_name: :random, max_concurrency: 1000)
    end
  },
  inputs: %{
    "input_mini" => input_mini,
    "input_small" => input_small,
    "input_medium" => input_medium,
    "input_large" => input_large,
    "input_xl" => input_xl,
    "input_xxl" => input_xxl,
    "input_xxxl" => input_xxxl
  }
)
