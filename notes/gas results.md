# gas results

- there is a difference in the gas usage from `forge test` and quick testing on remix
- both compilers set to 0.8.7

- local test command

  - forge test -vvvv > forge-test-output.txt
  - using `-vvvv` flag to get "trace" output to see called function gas costs

- reviewing the trace the gas costs do not match with the remix txs
  - `bat notes/forge-test-output.txt`
  - why are these costs different?
