// require("@nomiclabs/hardhat-ethers");
// 
// // 尝试加载加密的环境变量
// try {
//   require("@chainlink/env-enc").config();
// } catch (error) {
//   // 如果加密文件不存在，回退到普通的 dotenv
//   require("dotenv").config();
// }
// 
// /** @type import('hardhat/config').HardhatUserConfig */
// module.exports = {
//   solidity: "0.8.28",
//   networks: {
//     sepolia: {
//       url: process.env.SEPOLIA_RPC_URL,
//       accounts: [process.env.PRIVATE_KEY],
//     },
//   },
// };