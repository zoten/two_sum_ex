defmodule TwoSum.ParallelEts do
  @moduledoc """
  This module at the moment doesn't care about order of indexes.
  Parallel workers will just take the first matching pair in computation, not the
  first in the list. Changes to this behaviour are pretty trivial and
  overall complexity remains the same
  """
  @default_table :cache

  @spec run(input :: list(integer()), target :: integer()) ::
          {indexes :: {number0 :: integer(), number0 :: integer()},
           numbers :: {number0 :: integer(), number0 :: integer()}}
          | :not_found
  def run([_h | _t] = input, target, options \\ []) do
    table_name = Keyword.get(options, :table_name, @default_table)

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
      max_concurrency: 10
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
end
