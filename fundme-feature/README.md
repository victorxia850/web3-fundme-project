当然可以！以下是一个适合你这两个 Solidity 合约项目的 `README.md` 文件内容，你可以将其保存为 `README.md` 并上传到 GitHub 仓库中：

---

# 🚀 FundMe & FundTokenERC20 Smart Contracts

这是一个基于 Solidity 编写的众筹（Fundraising）智能合约项目，包含两个主要合约：

- **FundMe.sol**：用于管理资金募集、提款与退款逻辑。
- **FundTokenERC20.sol**：基于 ERC-20 标准的代币合约，用于向投资人发放代币，并支持代币领取、转账和销毁。

该项目使用 Chainlink 的价格预言机来将 ETH 转换为 USD 值，以判断是否满足最低投资金额或目标金额。

---

## 🔍 项目功能概览

### ✅ FundMe.sol
- 投资人可向合约发送 ETH（按 USD 计算需至少 1 USD）
- 生产商（合约所有者）可在筹款结束后提取资金（需达到目标金额 5 USD）
- 若未达成目标金额，投资人可在窗口期结束后申请退款
- 支持 Owner 变更
- 使用 Chainlink 获取 ETH/USD 价格数据

### ✅ FundTokenERC20.sol
- 投资人在筹款成功后可领取对应数量的 ERC-20 代币
- 代币总量与其在 `FundMe` 中的投资金额挂钩
- 支持代币转账（继承自 OpenZeppelin 的 `ERC20`）
- 支持代币销毁（Burn）

---

## 🧠 合约逻辑说明

### FundMe.sol

#### 📌 投资流程 (`fund`)
- 投资人通过调用 `fund()` 函数发送 ETH
- 每次投资必须满足最低金额要求（当前设定为 1 USD）
- 投资记录保存在 `funder2Amount` 映射中

#### 📌 提款流程 (`getFunds`)
- 仅限合约 Owner（生产商）调用
- 必须在窗口期结束后调用
- 必须满足总金额 ≥ 目标金额（当前为 5 USD）

#### 📌 退款流程 (`withdrawFunds`)
- 窗口期结束后，若未达标，投资人可调用此函数退款
- 每个投资人只能取回自己投入的部分

#### 📌 Chainlink 预言机集成
- 使用 `AggregatorV3Interface` 获取 ETH/USD 价格
- 当前使用的是 Goerli 测试网的价格源地址

---

### FundTokenERC20.sol

#### 📌 Mint Token (`mint`)
- 投资人根据其在 `FundMe` 合约中的投资金额领取代币
- 需确保已众筹成功（即 `getFundSuccess == true`）

#### 📌 Burn Token (`claim`)
- 投资人完成使用后可销毁代币（示例中未实现具体业务逻辑）

---

## ⚙️ 部署与测试建议

### 🧪 环境配置
- Solidity 版本：`^0.8.20`
- Chainlink 预言机地址：Goerli 测试网（`0x694AA1769357215DE4FAC081bf1f309aDC325306`）
- OpenZeppelin ERC20 库版本：最新版（请确保依赖安装正确）

### 🧩 部署顺序
1. 首先部署 `FundMe.sol`，传入锁定期时间 `_lockTime`
2. 部署 `FundTokenERC20.sol`，传入 `FundMe` 合约地址
3. 在 `FundMe` 中设置 `erc20Addr` 为刚刚部署的代币合约地址

---

## 📁 文件结构

```
.
├── FundMe.sol          # 主要资金管理合约
├── FundTokenERC20.sol  # ERC20 代币合约
└── README.md           # 项目说明文档
```

---

## 📦 依赖库

```bash
@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
@openzeppelin/contracts/token/ERC20/ERC20.sol
```

---

## 🛡️ 安全提示

- 所有外部调用均使用 `call` 替代 `transfer` 以避免 gas 限制问题
- 所有关键操作均有权限控制（如 onlyOwner）和状态检查（如 window 时间）
- 建议在主网上部署前进行完整审计

---

## 🤝 贡献者

欢迎提交 PR 或 Issue！

---

## 📜 License

MIT License

---