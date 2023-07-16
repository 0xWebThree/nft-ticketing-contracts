require("@nomicfoundation/hardhat-toolbox");
const fs = require('fs');

require('dotenv').config({ path: '.env'});
const { SIB_PROVIDER } = process.env;

const PRIVATE_KEY = fs.readFileSync(".secrets").toString();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19", // Recommended use latest solc & solidity version
  networks: {
    /*
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA}`,
      accounts: [`0x${PRIVATE_KEY}`],
      chainId: 11155111
    },
    goerli: {
      url: `https://goerli.infura.io/v3/${INFURA}`,
      accounts: [`0x${PRIVATE_KEY}`],
      chainId: 5
    },
    bsc_test: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      accounts: [`0x${PRIVATE_KEY}`],
      chainId: 97 
    },
    */
    siberium: {
      url: SIB_PROVIDER,
      accounts: [`0x${PRIVATE_KEY}`],
      chainId: 111000,
      gasPrice: 3000000000
    }
  },
  /*
  etherscan: {
    apiKey: ETHSKAN,
  },
  */
};