defmodule TwoSum do
  @moduledoc """
  Documentation for `TwoSum`.
  """

  alias TwoSum.Naive
  alias TwoSum.OnePassMap

  def run(_, [], _), do: :not_found
  def run(_, [_], _), do: :not_found
  def run(:naive, input, target), do: Naive.run(input, target)
  def run(:one_pass_map, input, target), do: OnePassMap.run(input, target)
end
