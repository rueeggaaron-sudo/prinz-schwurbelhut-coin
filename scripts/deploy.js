const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const treasuryAddress = process.env.TREASURY_ADDRESS || deployer.address;
  console.log("Treasury address set to:", treasuryAddress);

  const token = await hre.ethers.deployContract("PrinzSchwurbelhutCoin", [treasuryAddress]);

  await token.waitForDeployment();

  console.log(
    `PrinzSchwurbelhutCoin deployed to ${token.target}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
