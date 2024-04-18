defmodule TwoSum.OnePassMap do
  @spec run(input :: list(integer()), target :: integer()) ::
          {indexes :: {number0 :: integer(), number0 :: integer()},
           numbers :: {number0 :: integer(), number0 :: integer()}}
          | :not_found
  def run([h | t], target) do
    initial_acc = Map.new([{h, 0}])

    case t
         |> Enum.with_index()
         |> Enum.reduce_while(
           {:not_found, initial_acc},
           fn {number, idx}, {_, %{} = acc} ->
             search = target - number

             case Map.get(acc, search, :not_found) do
               :not_found -> {:cont, {:not_found, Map.put(acc, number, idx + 1)}}
               search_idx -> {:halt, {{search_idx, idx + 1}, {search, number}}}
             end
           end
         ) do
      {:not_found, _} -> :not_found
      result -> result
    end
  end
end
