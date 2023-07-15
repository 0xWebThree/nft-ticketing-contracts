import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  const wallet = (await ethers.getSigners())[0];

  console.log("Deploying contracts with the account:", deployer.address);

  const ticketPlace = await ethers.deployContract("Marketplace")
  await ticketPlace.waitForDeployment();

  console.log(
    `Marketplace address: ${ticketPlace.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
