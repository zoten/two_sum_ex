defmodule TwoSum do
  @moduledoc """
  Documentation for `TwoSum`.
  """

  alias TwoSum.Naive
  alias TwoSum.OnePassMap
  alias TwoSum.ParallelEts

  @type flavours :: :naive | :one_pass_map | :parallel_ets

  @spec run(
          flavour :: flavours(),
          input :: list(integer()),
          target :: integer(),
          options :: keyword()
        ) :: tuple() | :not_found
  def run(flavour, input, target, options \\ [])
  def run(_, [], _, _options), do: :not_found
  def run(_, [_], _, _options), do: :not_found
  def run(:naive, input, target, _options), do: Naive.run(input, target)
  def run(:one_pass_map, input, target, _options), do: OnePassMap.run(input, target)

  def run(:parallel_ets, input, target, options),
    do: ParallelEts.run(input, target, options)
end
