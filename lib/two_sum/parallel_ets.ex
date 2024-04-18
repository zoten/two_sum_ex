defmodule TwoSum.ParallelEts do
  @moduledoc """
  This module at the moment doesn't care about order of indexes.
  Parallel workers will just take the first matching pair in computation, not the
  first in the list. Changes to this behaviour are pretty trivial and
  overall complexity remains the same
  """
  @default_table :cache
  @default_max_concurrency 10

  @spec run(input :: list(integer()), target :: integer()) ::
          {indexes :: {number0 :: integer(), number0 :: integer()},
           numbers :: {number0 :: integer(), number0 :: integer()}}
          | :not_found
  def run([_h | _t] = input, target, options \\ []) do
    table_name = options |> Keyword.get(:table_name, @default_table) |> maybe_random_name()
    max_concurrency = Keyword.get(options, :max_concurrency, @default_max_concurrency)

    _table = :ets.new(table_name, [:named_table, :public])

    input
    |> Stream.with_index()
    |> Task.async_stream(
      fn {item, idx} ->
        :ets.insert(
          table_name,
          {item, {item, idx}}
        )

        search = target - item

        case :ets.lookup(table_name, search) do
          [{search, {search, search_idx}}] ->
            {:found, {{idx, search_idx}, {item, search}}}

          _ ->
            :not_found
        end
      end,
      max_concurrency: max_concurrency
    )
    |> Enum.reduce_while(
      :not_found,
      fn
        {:ok, :not_found}, _ ->
          {:cont, :not_found}

        {:ok, {:found, result}}, _ ->
          {:halt, result}

        result, acc ->
          raise "I don't expect parallel errors, come on, got [#{inspect(result)}] [#{inspect(acc)}]"
      end
    )
    |> maybe_normalize_result()
  end

  defp maybe_normalize_result(:not_found), do: :not_found

  defp maybe_normalize_result({{idx0, idx1}, {item0, item1}}) do
    if idx0 > idx1 do
      {{idx1, idx0}, {item1, item0}}
    else
      {{idx0, idx1}, {item0, item1}}
    end
  end

  @symbols ~c"0123456789abcdef"
  @symbol_count Enum.count(@symbols)

  defp maybe_random_name(:random),
    do:
      for(_ <- 1..20, into: "", do: <<Enum.at(@symbols, :rand.uniform(@symbol_count) - 1)>>)
      |> String.to_atom()

  defp maybe_random_name(name), do: name
end
