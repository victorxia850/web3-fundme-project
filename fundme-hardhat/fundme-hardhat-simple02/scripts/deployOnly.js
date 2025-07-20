// scripts/deployOnly.js

const { deployFundMe } = require("./deployFundMe");

async function main() {
  console.log("🚀 开始仅部署 FundMe 合约（不验证）...");
  
  try {
    const lockTime = 30 * 24 * 60 * 60; // 30天
    const result = await deployFundMe(lockTime);
    
    console.log("\n📋 部署结果摘要:");
    console.log("📍 合约地址:", result.address);
    console.log("🔒 锁定时间:", result.lockTime, "秒");
    console.log("👑 所有者:", result.owner);
    console.log("📅 部署时间戳:", result.deploymentTimestamp.toString());
    
    console.log("\n💡 如需验证合约，请运行:");
    console.log(`npm run verify:deployed ${result.address}`);
    
  } catch (error) {
    console.error("❌ 部署失败:", error);
    process.exit(1);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ 脚本执行失败:", error);
    process.exit(1);
  }); 