# Prinz Schwurbelhut Coin (PSHC)

This is a Hardhat project for the **Prinz Schwurbelhut Coin (PSHC)** on the BNB Smart Chain (BSC).

## Specifications

- **Name:** Prinz Schwurbelhut Coin
- **Symbol:** PSHC
- **Decimals:** 0
- **Total Supply:** 21,000,000,000
- **Tax:** 4.2% (2.1% Burn, 2.1% Treasury)
- **Limits:** Max Tx (1%), Max Wallet (2%)

## Project Structure

- `contracts/`: Solidity smart contracts
- `scripts/`: Deployment scripts
- `assets/`: Project assets

## Setup

1. **Install Dependencies**

   ```bash
   npm install
   ```

2. **Configuration**

   Copy `.env.example` to `.env` and fill in your details:

   ```bash
   cp .env.example .env
   ```

   - `PRIVATE_KEY`: Your wallet private key (deployer).
   - `BSCSCAN_API_KEY`: API key for contract verification.
   - `TREASURY_ADDRESS`: (Optional) Address to receive treasury fees. Defaults to deployer if not set.

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

**BSC Testnet:**

```bash
npx hardhat run scripts/deploy.js --network bscTestnet
```

**BSC Mainnet:**

```bash
npx hardhat run scripts/deploy.js --network bscMainnet
```

### Verify Contract

After deployment, verify the contract on BscScan:

```bash
npx hardhat verify --network <network> <DEPLOYED_CONTRACT_ADDRESS> <TREASURY_ADDRESS>
```

*Note: If you used the default deployer address as treasury, pass that address.*

## Assets

- **Logo:** `assets/prinz-schwurbelhut.jpg`
- **Raw Link:** `https://github.com/<YOUR_USERNAME>/<YOUR_REPO>/raw/main/assets/prinz-schwurbelhut.jpg` (Replace with your repository details)
