# FundMe - 智能合约众筹项目

一个基于 Hardhat 和 Chainlink 的去中心化众筹智能合约项目，支持 ETH 众筹、价格预言机集成和自动验证功能。

## 📋 项目概述

FundMe 是一个去中心化众筹平台，允许用户通过 ETH 进行众筹投资。项目集成了 Chainlink 价格预言机来获取实时 ETH/USD 价格，并提供了完整的部署、验证和管理工具。

### 🎯 核心功能

- **众筹投资**: 用户可以使用 ETH 进行投资，最低投资额为 1 USD
- **价格预言机**: 集成 Chainlink 实时获取 ETH/USD 价格
- **时间窗口**: 支持设置众筹时间窗口，过期后无法投资
- **自动提款**: 达到目标金额后，项目方可以提取资金
- **退款机制**: 未达到目标时，投资者可以申请退款
- **所有权管理**: 支持转移合约所有权

## 🏗️ 技术架构

### 核心技术栈
- **Solidity**: 0.8.28 - 智能合约开发语言
- **Hardhat**: 2.19.0 - 以太坊开发框架
- **Ethers.js**: 5.7.2 - 以太坊 JavaScript API
- **Chainlink**: 价格预言机集成
- **Sepolia**: 以太坊测试网络

### 项目结构
```
fundme-hardhat-simple02/
├── contracts/           # 智能合约源码
│   └── FundMe.sol      # 主合约
├── scripts/            # 部署和验证脚本
│   ├── deployFundMe.js # 主部署脚本
│   ├── deployOnly.js   # 仅部署脚本
│   ├── verifyFundMe.js # 验证脚本
│   └── verifyContract.js # 通用验证脚本
├── test/               # 测试文件
├── hardhat.config.js   # Hardhat 配置
├── package.json        # 项目依赖
└── README.md          # 项目文档
```

## 🚀 快速开始

### 环境要求
- Node.js >= 16.0.0
- npm >= 8.0.0
- Git

### 安装步骤

1. **克隆项目**
```bash
git clone <repository-url>
cd fundme-hardhat-simple02
```

2. **安装依赖**
```bash
npm install
```

3. **配置环境变量**
```bash
# 创建 .env 文件
cp .env.example .env

# 编辑 .env 文件，填入以下信息：
SEPOLIA_RPC_URL=your_sepolia_rpc_url
PRIVATE_KEY=your_private_key
ETHERSCAN_API_KEY=your_etherscan_api_key
```

4. **编译合约**
```bash
npx hardhat compile
```

## 📜 智能合约功能详解

### FundMe.sol 合约功能

#### 🔧 构造函数参数
- `_lockTime`: 众筹时间窗口（秒），默认 30 天

#### 💰 核心函数

**1. fund() - 投资函数**
```solidity
function fund() external payable checkInWindowTime
```
- 功能：投资者使用 ETH 进行投资
- 要求：投资金额 >= 1 USD
- 限制：必须在时间窗口内

**2. withdrawFunds() - 提款函数**
```solidity
function withdrawFunds() external onlyByOwner checkNotInWindowClosed
```
- 功能：项目方提取众筹资金
- 要求：达到目标金额（5 USD）
- 限制：仅合约所有者可调用

**3. claimRefund() - 退款函数**
```solidity
function claimRefund() external checkNotInWindowClosed
```
- 功能：投资者申请退款
- 要求：未达到目标金额
- 限制：窗口期结束后

**4. updateOwnerShip() - 所有权转移**
```solidity
function updateOwnerShip(address newOwner) public onlyByOwner
```
- 功能：转移合约所有权
- 限制：仅当前所有者可调用

#### 🔗 Chainlink 集成

**价格预言机功能**
- 使用 Sepolia 网络的 ETH/USD 价格预言机
- 地址：`0x694AA1769357215DE4FAC081bf1f309aDC325306`
- 支持实时 ETH 到 USD 的价格转换

**价格转换函数**
```solidity
function eth2Usd(uint256 ethAmount) public view returns (uint256)
function getLatestPrice() public view returns (int)
```

#### ⏰ 时间管理

**修饰符**
- `checkInWindowTime`: 检查是否在众筹窗口期内
- `checkNotInWindowClosed`: 检查窗口期是否已结束
- `onlyByOwner`: 检查是否为合约所有者

## 🛠️ Hardhat 开发流程

### 1. 项目初始化
```bash
# 创建 Hardhat 项目
npx hardhat init

# 安装依赖
npm install @nomiclabs/hardhat-ethers ethers@^5.7.2
npm install @nomiclabs/hardhat-etherscan
npm install @chainlink/contracts
npm install dotenv
```

### 2. 配置 Hardhat
```javascript
// hardhat.config.js
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};
```

### 3. 合约开发
- 编写 Solidity 合约
- 集成 Chainlink 预言机
- 实现业务逻辑

### 4. 测试
```bash
npx hardhat test
```

### 5. 部署
```bash
npx hardhat run scripts/deployFundMe.js --network sepolia
```

### 6. 验证
```bash
npx hardhat verify --network sepolia <合约地址> <构造函数参数>
```

## 📝 可用命令

### 🚀 部署命令

| 命令 | 描述 | 用法 |
|------|------|------|
| `npm run deploy` | 部署并自动验证合约 | `npm run deploy` |
| `npm run deploy:only` | 仅部署合约（不验证） | `npm run deploy:only` |
| `npm run deploy:verify` | 部署并验证合约 | `npm run deploy:verify` |

### 🔐 验证命令

| 命令 | 描述 | 用法 |
|------|------|------|
| `npm run verify` | 验证预定义的 FundMe 合约 | `npm run verify` |
| `npm run verify:deployed` | 验证刚部署的合约 | `npm run verify:deployed <地址>` |
| `npm run verify:contract` | 验证任意合约 | `npm run verify:contract <地址> <参数>` |
| `npm run verify:manual` | 手动验证 | `npm run verify:manual <地址> <参数>` |

### 🧪 测试命令

| 命令 | 描述 | 用法 |
|------|------|------|
| `npm test` | 运行测试 | `npm test` |
| `npx hardhat test` | 运行 Hardhat 测试 | `npx hardhat test` |

### 🔧 开发命令

| 命令 | 描述 | 用法 |
|------|------|------|
| `npx hardhat compile` | 编译合约 | `npx hardhat compile` |
| `npx hardhat clean` | 清理编译缓存 | `npx hardhat clean` |
| `npx hardhat node` | 启动本地节点 | `npx hardhat node` |

## 🔧 脚本功能详解

### deployFundMe.js
主部署脚本，支持多种操作模式：

**功能函数**
- `deployFundMe()`: 仅部署合约
- `verifyFundMe()`: 仅验证合约
- `deployAndVerify()`: 部署并验证

**命令行参数**
```bash
# 仅部署
npx hardhat run scripts/deployFundMe.js deploy-only --network sepolia

# 仅验证
npx hardhat run scripts/deployFundMe.js verify <合约地址> --network sepolia

# 部署并验证
npx hardhat run scripts/deployFundMe.js deploy-and-verify --network sepolia
```

### deployOnly.js
专门用于仅部署操作的脚本，提供清晰的部署结果摘要。

### verifyFundMe.js
验证预定义的 FundMe 合约，适合验证已知地址的合约。

### verifyContract.js
通用验证脚本，支持任意合约地址和构造函数参数。

## 🔗 网络配置

### Sepolia 测试网
- **RPC URL**: 需要配置 Alchemy 或 Infura 的 Sepolia 端点
- **Chain ID**: 11155111
- **区块浏览器**: https://sepolia.etherscan.io/

### 环境变量配置
```bash
# .env 文件示例
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_API_KEY
PRIVATE_KEY=your_wallet_private_key
ETHERSCAN_API_KEY=your_etherscan_api_key
```

## 🔒 安全考虑

### 合约安全
- 使用 OpenZeppelin 的安全模式
- 实现访问控制修饰符
- 安全的资金转移机制
- 时间窗口管理

### 开发安全
- 私钥使用环境变量管理
- 测试网络优先部署
- 合约验证确保代码透明
- 多重签名钱包支持

## 🧪 测试

### 运行测试
```bash
npm test
```

### 测试覆盖
- 合约部署测试
- 投资功能测试
- 提款功能测试
- 退款功能测试
- 时间窗口测试
- 价格预言机测试

## 📚 相关文档

- [Hardhat 官方文档](https://hardhat.org/docs)
- [Solidity 文档](https://docs.soliditylang.org/)
- [Chainlink 文档](https://docs.chain.link/)
- [Ethers.js 文档](https://docs.ethers.io/)
- [Etherscan API 文档](https://docs.etherscan.io/)

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系方式

- 项目链接: [https://github.com/your-username/fundme-hardhat-simple02](https://github.com/your-username/fundme-hardhat-simple02)
- 问题反馈: [Issues](https://github.com/your-username/fundme-hardhat-simple02/issues)

---

⭐ 如果这个项目对您有帮助，请给它一个星标！
