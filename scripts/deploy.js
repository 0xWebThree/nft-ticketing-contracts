async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const ticketPlace = await ethers.getContractFactory("Marketplace");
  const deployedContract = await ticketPlace.deploy();

  console.log("Deployed marketplace address:", await deployedContract.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });