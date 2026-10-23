# Prinz Schwurbelhut Coin (PSHC)

<img src="assets/prinz-schwurbelhut.jpg" width="320">

Hardhat project for the **Prinz Schwurbelhut Coin (PSHC)** on the BNB Smart Chain (BSC).

---

## Disclaimer

This is a purely experimental token project ("Schwurbel-Experiment") created for testing smart contract deployment, tokenomics mechanics, and tooling workflows.

* No financial advice
* No guarantees
* No roadmap
* No utility
* Just vibes and whole hats

Use at your own risk.

---

## Deployments

### BSC Testnet

* Contract: `0x17b315E0200698B2b5Cd8267B8C35e38a0629CF9`
* Explorer: [https://testnet.bscscan.com/address/0x17b315E0200698B2b5Cd8267B8C35e38a0629CF9](https://testnet.bscscan.com/address/0x17b315E0200698B2b5Cd8267B8C35e38a0629CF9)

---

## Specifications

* **Name:** Prinz Schwurbelhut Coin
* **Symbol:** PSHC
* **Decimals:** 0 (nur ganze Hüte)
* **Total Supply:** 21,000,000,000
* **Transfer Tax:** 4.2%

  * 2.1% Burn
  * 2.1% Treasury
* **Limits:**

  * Max Tx: 1%
  * Max Wallet: 2%

---

## Project Structure

* `contracts/` – Solidity smart contracts
* `scripts/` – Deployment scripts
* `assets/` – Project assets

---

## Setup

For repository and Git work, follow the central
[GIT_HANDOFF.md](https://github.com/rueeggaaron-sudo/orchestrator/blob/main/GIT_HANDOFF.md).
The local validation reference is Node.js 22.23.4 (Node.js 22.12 or 24).
Install locked dependencies with lifecycle scripts disabled:

```bash
npm ci --ignore-scripts
```

Do not create or load a `.env` file for local compile/test checks. The deploy
commands below are separate release actions and are not part of local CI.

### Local compile and test inventory

The project compile gate uses the exact compiler and optimizer configuration
from `hardhat.config.js`:

```bash
npm run compile
```

Hardhat may download the official solc binary if it is not already cached.
This is a compiler download only; it does not use the configured chain RPCs.

The dependency tree also includes `solcjs` 0.8.26 for an offline syntax and
bytecode compile, but this is not the project's exact 0.8.20 compile gate:

```bash
mkdir -p /tmp/pshc-solc-output
./node_modules/.bin/solcjs --base-path . --include-path node_modules \
  --optimize --optimize-runs 200 --bin --abi \
  -o /tmp/pshc-solc-output contracts/PrinzSchwurbelhutCoin.sol
```

The `test/` directory currently contains no tests. `npm test -- --no-compile`
reports zero passing tests and is only a test-suite inventory check, not
behavioral coverage. Run `npm audit --audit-level=low` separately and keep the
security result red if advisories remain.

### Install Dependencies

```bash
npm ci --ignore-scripts
```

### Configuration

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Fill in:

* `PRIVATE_KEY` – Deployer wallet private key
* `BSCSCAN_API_KEY` – Required for contract verification
* `TREASURY_ADDRESS` – Optional (defaults to deployer if omitted)

---

## Usage

### Compile

Run `npm run compile` to use the exact configured compiler version and
optimizer settings. For an offline syntax-only alternative, use the `solcjs`
0.8.26 command above; it does not replace the configured compiler gate.

### Test

(Add tests in `test/` directory if desired)

```bash
npx hardhat test
```

### Deploy

**BSC Testnet**

```bash
npx hardhat run scripts/deploy.js --network bscTestnet
```

**BSC Mainnet**

```bash
npx hardhat run scripts/deploy.js --network bscMainnet
```

---

## Verify Contract

After deployment, verify the contract on BscScan:

```bash
npx hardhat verify --network <network> <DEPLOYED_CONTRACT_ADDRESS> <TREASURY_ADDRESS>
```

Note: If you used the deployer address as treasury, pass that same address.

---

## Assets

* Logo: `assets/prinz-schwurbelhut.jpg`
* Raw Image Link:
  [https://raw.githubusercontent.com/rueeggaaron-sudo/prinz-schwurbelhut-coin/main/assets/prinz-schwurbelhut.jpg](https://raw.githubusercontent.com/rueeggaaron-sudo/prinz-schwurbelhut-coin/main/assets/prinz-schwurbelhut.jpg)
