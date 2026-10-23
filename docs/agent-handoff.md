# Agent handoff

## Local validation

Use the central [GIT_HANDOFF.md](https://github.com/rueeggaaron-sudo/orchestrator/blob/main/GIT_HANDOFF.md)
and Node.js 22.12 or 24 (verified local runtime: 22.23.4). Run
`npm ci --ignore-scripts` with a task-private `HOME` and npm cache. Do not load
`.env` values for local checks.

The locked Hardhat tree includes local `solcjs` 0.8.26. An offline syntax and
bytecode compilation can run with:

```bash
./node_modules/.bin/solcjs --base-path . --include-path node_modules \
  --optimize --optimize-runs 200 --bin --abi \
  -o /tmp/pshc-solc-output contracts/PrinzSchwurbelhutCoin.sol
```

The contract pragma is `^0.8.20`, while `hardhat.config.js` selects 0.8.20.
The local package compiler is 0.8.26, so the offline compile does not verify
the exact configured compiler build. The test directory has no committed test
cases; `npm test -- --no-compile` returned `0 passing`, which is inventory only
and not contract behavior coverage. `npm audit --audit-level=low` returned 61
advisories on 2026-10-23 (18 low, 12 moderate, 30 high, 1 critical). No
dependency changes were made for this CI documentation task.

## Current candidate

Candidate base: `c1ec3c40686f85c678e040d3c186012b4ee50c30`.
Receipt: `/private/tmp/agency-ci-proof-20261023/prinz-schwurbelhut-coin.json`.
No wallet, key, chain, RPC, faucet, contract deployment, or provider was used.
