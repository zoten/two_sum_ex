# TwoSum

Some implementations of the classical [Two Sum Problem](https://leetcode.com/problems/two-sum/description/) LeetCode exercise, with some benchmark

## Usage

### Setup

``` bash
mix deps.get
```

### Run benchmarks

``` bash
mix run benches/two_sum.exs
```

## Afterthoughts

### Code limitations

 * The `ParallelEts` implementation keeps a shortcut respect the others, and finds the first pair of indexes/values matching the target, while the other implementations give the first in list order (left to right)

### Outcome

Tests have been performed mainly on a busy laptop with no scientific value. It is interesting to find the moment when the parallel ets implementation beats the most "academic" ones, and with which kind of parallelism. Opens some space for an flamegraph introspection in the future.
