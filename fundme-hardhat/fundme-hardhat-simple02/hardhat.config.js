require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
      chainId: 11155111, // Sepolia chain ID: 可以通过此参数来判断部署的网络是否正确
    },
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_API_KEY
    }
  },
};