// scripts/verifyFundMe.js

async function main() {
  const chainId = (await ethers.provider.getNetwork()).chainId;
  if (chainId !== 11155111) {
    console.log("⚠️ 当前网络不是 Sepolia（chainId: 11155111），跳过合约验证。");
    return;
  }
  const apiKey = process.env.ETHERSCAN_API_KEY;
  if (!apiKey) {
    console.log("⚠️ 未检测到 ETHERSCAN_API_KEY，跳过合约验证。");
    return;
  }
  // 🔍 合约地址和构造函数参数
  const contractAddress = "0x6BEbd9C82572975020dC08C9F96aDfdc64c37436"; // 替换为您的合约地址
  const lockTime = 30 * 24 * 60 * 60; // 30天，与部署时保持一致

  console.log("🔐 开始验证合约...");
  console.log("📍 合约地址:", contractAddress);
  console.log("🔒 锁定时间:", lockTime, "秒");

  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: [lockTime],
    });
    console.log("✅ 合约验证成功！");
    console.log("🔗 查看合约: https://sepolia.etherscan.io/address/" + contractAddress);
  } catch (error) {
    if (error.message.includes("Already Verified")) {
      console.log("ℹ️ 合约已经验证过了");
      console.log("🔗 查看合约: https://sepolia.etherscan.io/address/" + contractAddress);
    } else {
      console.log("❌ 合约验证失败:", error.message);
      console.log("💡 请检查:");
      console.log("   1. 合约地址是否正确");
      console.log("   2. 构造函数参数是否正确");
      console.log("   3. 网络连接是否正常");
      console.log("   4. Etherscan API 密钥是否有效");
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Verification failed:", error);
    process.exit(1);
  }); 