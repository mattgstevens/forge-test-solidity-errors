# gas results

- there is a difference in the gas usage from `forge test` and quick testing on remix
- both compilers set to 0.8.7

- local test command

  - forge test > notes/forge-test-output.txt

- reviewing the trace the gas costs do not match with the remix txs
  - `bat notes/forge-test-output.txt`
  - why are these costs different?
