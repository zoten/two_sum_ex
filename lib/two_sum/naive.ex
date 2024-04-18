defmodule TwoSum.Naive do
  @spec run(input :: list(integer()), target :: integer()) ::
          {indexes :: {number0 :: integer(), number0 :: integer()},
           numbers :: {number0 :: integer(), number0 :: integer()}}
          | :not_found
  def run([_h | t] = input, target) do
    input
    |> Enum.with_index()
    |> Enum.reduce_while(
      {:not_found, t},
      fn {number, number_index}, {_, [_rh | rt] = remaining} ->
        case remaining
             |> Enum.with_index()
             |> Enum.reduce_while(
               :not_found,
               fn {other_number, other_number_index}, _ ->
                 if number + other_number == target do
                   {:halt, {other_number, other_number_index}}
                 else
                   {:cont, :not_found}
                 end
               end
             ) do
          {other_number, other_number_index} ->
            {:halt,
             {{number_index, other_number_index + number_index + 1}, {number, other_number}}}

          :not_found ->
            {:cont, {:not_found, rt}}
        end
      end
    )
  end

  def run(_, _), do: :not_found
end
