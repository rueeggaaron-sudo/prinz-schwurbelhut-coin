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

### Install Dependencies

```bash
npm install
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

```bash
npx hardhat compile
```

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
