// scripts/deployFundMe.js

// ✅ 正确引入 ethers
const { ethers } = require("hardhat");

/**
 * 🔧 部署 FundMe 合约
 * @param {number} lockTime - 锁定时间（秒）
 * @returns {Object} 部署结果对象
 */
async function deployFundMe(lockTime = 30 * 24 * 60 * 60) {
  console.log("🚀 开始部署 FundMe 合约...");
  console.log("🔒 锁定时间:", lockTime, "秒");

  // ✅ 使用 ethers 获取合约工厂
  const FundMe = await ethers.getContractFactory("FundMe");

  // 部署合约
  const fundMe = await FundMe.deploy(lockTime);
  await fundMe.deployed();

  console.log("✅ FundMe 合约部署成功！");
  console.log("📍 合约地址:", fundMe.address);
  console.log("👑 所有者:", await fundMe.owner());
  console.log("📅 部署时间戳:", (await fundMe.deploymentTimestamp()).toString());

  return {
    contract: fundMe,
    address: fundMe.address,
    lockTime: lockTime,
    owner: await fundMe.owner(),
    deploymentTimestamp: await fundMe.deploymentTimestamp()
  };
}

/**
 * 🔐 验证 FundMe 合约
 * @param {string} contractAddress - 合约地址
 * @param {number} lockTime - 锁定时间（秒）
 * @returns {boolean} 验证是否成功
 */
async function verifyFundMe(contractAddress, lockTime = 30 * 24 * 60 * 60) {
  console.log("🔐 开始验证 FundMe 合约...");
  console.log("📍 合约地址:", contractAddress);
  console.log("🔒 锁定时间:", lockTime, "秒");

  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: [lockTime],
    });
    console.log("✅ 合约验证成功！");
    console.log("🔗 查看合约: https://sepolia.etherscan.io/address/" + contractAddress);
    return true;
  } catch (error) {
    if (error.message.includes("Already Verified")) {
      console.log("ℹ️ 合约已经验证过了");
      console.log("🔗 查看合约: https://sepolia.etherscan.io/address/" + contractAddress);
      return true;
    } else {
      console.log("❌ 合约验证失败:", error.message);
      console.log("💡 请检查:");
      console.log("   1. 合约地址是否正确");
      console.log("   2. 构造函数参数是否正确");
      console.log("   3. 网络连接是否正常");
      console.log("   4. Etherscan API 密钥是否有效");
      return false;
    }
  }
}

/**
 * 🚀 部署并验证 FundMe 合约（完整流程）
 * @param {number} lockTime - 锁定时间（秒）
 * @param {boolean} shouldVerify - 是否进行验证
 */
async function deployAndVerify(lockTime = 30 * 24 * 60 * 60, shouldVerify = true) {
  try {
    // 1. 部署合约
    const deploymentResult = await deployFundMe(lockTime);
    
    // 2. 等待区块确认
    if (shouldVerify) {
      console.log("⏳ 等待区块确认...");
      await deploymentResult.contract.deployTransaction.wait(6); // 等待6个区块确认
      
      // 3. 验证合约
      const verificationSuccess = await verifyFundMe(deploymentResult.address, lockTime);
      
      if (verificationSuccess) {
        console.log("🎉 部署和验证流程完成！");
      } else {
        console.log("⚠️ 部署成功，但验证失败");
      }
    }
    
    return deploymentResult;
  } catch (error) {
    console.error("❌ 部署和验证失败:", error);
    throw error;
  }
}

/**
 * 📋 主函数 - 根据命令行参数执行不同操作
 */
async function main() {
  const args = process.argv.slice(2);
  const command = args[0] || 'deploy-and-verify'; // 默认执行部署
  
  const lockTime = 30 * 24 * 60 * 60; // 30天
  
  try {
    switch (command) {
      case 'deploy':
        // 仅部署
        await deployFundMe(lockTime);
        break;
        
      case 'verify':
        // 仅验证
        const contractAddress = args[1];
        if (!contractAddress) {
          console.error("❌ 请提供合约地址");
          console.log("💡 使用方法: npm run deploy:verify <合约地址>");
          process.exit(1);
        }
        await verifyFundMe(contractAddress, lockTime);
        break;
        
      case 'deploy-and-verify':
        // 部署并验证
        await deployAndVerify(lockTime, true);
        break;
        
      case 'deploy-only':
        // 仅部署不验证
        await deployAndVerify(lockTime, false);
        break;
        
      default:
        // 默认：部署并验证
        await deployAndVerify(lockTime, true);
        break;
    }
  } catch (error) {
    console.error("❌ 操作失败:", error);
    process.exit(1);
  }
}

// 导出函数供其他脚本使用
module.exports = {
  deployFundMe,
  verifyFundMe,
  deployAndVerify
};

// 如果直接运行此脚本
if (require.main === module) {
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error("❌ 脚本执行失败:", error);
      process.exit(1);
    });
}