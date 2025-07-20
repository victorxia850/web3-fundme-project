async function main() {
  // 获取当前时间戳并设置一个解锁时间，比如当前时间 + 7 天（以秒为单位）
  const unlockTime = Math.floor(Date.now() / 1000) + 60 * 60 * 24 * 7; // 7天后解锁
  const LOCKED_AMOUNT = ethers.parseEther("1"); // 合约部署时锁定 1 ETH

  // 获取合约工厂
  const Lock = await ethers.getContractFactory("Lock");

  // 部署合约
  const lock = await Lock.deploy(unlockTime, { value: LOCKED_AMOUNT });

  // 等待合约交易被确认（部署完成）
  await lock.deploymentTransaction().wait(); // 替代 .deployed()

  // 输出合约地址
  const contractAddress = await lock.getAddress(); // 获取合约地址
  console.log("Lock contract deployed to:", contractAddress);
  console.log("Unlock time:", new Date(unlockTime * 1000));
}

// 执行部署函数
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("部署过程中发生错误：", error);
    process.exit(1);
  });