# 合约部署和验证指南

本项目提供了模块化的合约部署和验证功能，支持灵活的操作组合。

## 🚀 部署方式

### 1. 部署并自动验证（推荐）
```bash
npm run deploy
# 或
npm run deploy:verify
```

### 2. 仅部署（不验证）
```bash
npm run deploy:only
```

### 3. 使用独立脚本部署
```bash
npx hardhat run scripts/deployOnly.js --network sepolia
```

## 🔐 验证方式

### 1. 验证刚部署的合约
```bash
npm run verify:deployed <合约地址>
```

### 2. 验证特定的 FundMe 合约
```bash
npm run verify
```

### 3. 通用验证
```bash
npm run verify:contract <合约地址> [构造函数参数...]
```

### 4. 手动验证
```bash
npm run verify:manual <合约地址> [构造函数参数...]
```

## 📋 使用示例

### 完整流程（部署+验证）
```bash
# 方式1：一步完成
npm run deploy

# 方式2：分步完成
npm run deploy:only
npm run verify:deployed 0x1234...
```

### 仅部署
```bash
npm run deploy:only
```

### 仅验证
```bash
npm run verify:deployed 0x6BEbd9C82572975020dC08C9F96aDfdc64c37436
```

## 🔧 脚本功能说明

### deployFundMe.js
- `deployFundMe()` - 仅部署合约
- `verifyFundMe()` - 仅验证合约
- `deployAndVerify()` - 部署并验证
- 支持命令行参数控制操作

### deployOnly.js
- 专门用于仅部署操作
- 提供清晰的部署结果摘要
- 提示后续验证命令

### verifyFundMe.js
- 验证预定义的 FundMe 合约
- 适合验证已知地址的合约

### verifyContract.js
- 通用验证脚本
- 支持任意合约地址和参数

## 📋 验证前准备

1. **确保环境变量正确**：
   ```bash
   # .env 文件
   SEPOLIA_RPC_URL=your_rpc_url
   PRIVATE_KEY=your_private_key
   ETHERSCAN_API_KEY=your_etherscan_api_key
   ```

2. **检查网络连接**：
   - 确保能够访问 Sepolia 网络
   - 确保 Etherscan API 密钥有效

3. **确认合约信息**：
   - 合约地址正确
   - 构造函数参数正确
   - 合约已部署到目标网络

## 🔍 验证流程

1. **等待区块确认**：部署后等待 6 个区块确认
2. **提交验证请求**：向 Etherscan 提交验证请求
3. **编译验证**：Etherscan 编译合约源码
4. **字节码对比**：对比部署的字节码
5. **验证成功**：显示验证结果和合约链接

## ❗ 常见问题

### 验证失败
- 检查合约地址是否正确
- 确认构造函数参数
- 验证网络连接
- 检查 API 密钥

### 已验证
- 如果合约已经验证过，会显示相应提示
- 可以直接访问 Etherscan 查看合约

### 网络超时
- 增加等待时间
- 检查网络连接
- 重试验证

## 🎯 最佳实践

1. **开发阶段**：使用 `npm run deploy:only` 快速部署
2. **测试阶段**：使用 `npm run verify:deployed` 验证合约
3. **生产阶段**：使用 `npm run deploy` 一键部署并验证
4. **批量操作**：使用 `npm run verify:contract` 验证多个合约

## 🔗 相关链接

- [Hardhat 验证文档](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan)
- [Etherscan API](https://docs.etherscan.io/)
- [Sepolia 测试网](https://sepolia.etherscan.io/) 