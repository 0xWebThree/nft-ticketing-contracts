import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const { mnemonic } = require('./secrets.json');

const config: HardhatUserConfig = {
  defaultNetwork: "siberium",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    hardhat: {

    },
    siberium: {
      url: "https://rpc.test.siberium.net",
      gasPrice: 20000000000,
      chainId: 111000,
      accounts: {mnemonic: mnemonic}
    },
  },
  solidity: {
    version:"0.8.20",
    settings: {
      optimizer: {
        enabled: true
      }
    }
  },
  paths: {
    sources: "./contracts",
  } 
};

export default config;
