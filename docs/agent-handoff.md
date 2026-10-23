# Agent handoff

## Local validation

Use the central [GIT_HANDOFF.md](https://github.com/rueeggaaron-sudo/orchestrator/blob/main/GIT_HANDOFF.md)
and Node.js 22.12 or 24 (verified local runtime: 22.23.4). Run
`npm ci --ignore-scripts` with a task-private `HOME` and npm cache. Do not load
`.env` values for local checks.

Run `npm run compile` for the configured Hardhat compiler, solc 0.8.20, and
optimizer settings. On this candidate Hardhat downloaded the official 0.8.20
compiler binary and compiled the contract plus six imported Solidity files
successfully. The compile task only used the compiler download; configured
network URLs were not contacted and there was no `.env` file.

The locked Hardhat tree also includes local `solcjs` 0.8.26 for an offline
syntax/bytecode check (not a substitute for the configured compiler gate):

```bash
./node_modules/.bin/solcjs --base-path . --include-path node_modules \
  --optimize --optimize-runs 200 --bin --abi \
  -o /tmp/pshc-solc-output contracts/PrinzSchwurbelhutCoin.sol
```

The test directory has no committed test cases; `npm test -- --no-compile`
returned `0 passing`, which is inventory only and not contract behavior
coverage. `npm audit --audit-level=low` returned 61 advisories on 2026-10-23
(18 low, 12 moderate, 30 high, 1 critical). No dependency changes were made
for this CI documentation task.

## Current candidate

Candidate base: `c1ec3c40686f85c678e040d3c186012b4ee50c30`.
Receipt: `/private/tmp/agency-ci-proof-20261023/prinz-schwurbelhut-coin.json`.
No wallet, key, chain, RPC, faucet, contract deployment, or provider was used.
