# Coin 和 Token 的区别

## 🧠 一句话理解

> **Coin 是原生货币，Token 是基于某个平台发行的资产。**

---

## ✅ 对比表

| 特性         | Coin（币）                            | Token（代币）                          |
|--------------|----------------------------------------|----------------------------------------|
| 是否原生     | ✅ 是原生资产                         | ❌ 是在已有区块链上发行的资产         |
| 是否有独立链 | ✅ 有自己的区块链                     | ❌ 依赖其他区块链（如以太坊）         |
| 示例         | BTC、ETH、BNB、SOL                   | USDT（ERC20）、UNI、LINK、APE         |
| 使用场景     | 通常用于支付、价值存储、挖矿         | 表示权益、使用权、门票、游戏道具等   |
| 技术标准     | 没有特定标准，自定义底层实现         | 遵循标准（如 ERC-20, ERC-721）        |
| 交易方式     | 直接在链上转账                       | 依赖智能合约转账                      |

---

## 🪙 常见 Coin（有独立区块链）

| 名称   | 区块链        |
|--------|----------------|
| BTC    | 比特币         |
| ETH    | 以太坊         |
| BNB    | BNB Chain      |
| SOL    | Solana         |
| ADA    | Cardano        |

---

## 🏷️ 常见 Token（依附于平台）

| Token   | 所属区块链   | 类型               |
|---------|----------------|--------------------|
| USDT    | 以太坊、TRON等 | ERC-20, TRC-20 等 |
| UNI     | 以太坊         | ERC-20            |
| APE     | 以太坊         | ERC-20            |
| MATIC   | 以太坊         | ERC-20            |
| NFT     | 以太坊         | ERC-721 / ERC-1155|

---

## 📌 类比理解

- 🪙 **Coin** 就像“国家的货币”（例如：美元、人民币）——它是这个系统的根基。
- 🏷️ **Token** 就像“公司发行的积分”（例如：游戏点数、星巴克积分）——它依附于某个平台运行。

---

> 如果你正在开发 DApp、做合约交互、写钱包逻辑等，可以根据你是否依赖平台来决定使用 Coin 还是 Token。

# 常见的 Token 定义与分类

在区块链和 Web3 领域，**Token（代币）** 是构建在区块链上的一种**数字资产或数字权益表示**，它们可以用于交换、交易、治理、奖励等目的。

---

## 🧩 一、Token 的通用属性

不论是哪种 Token 类型（ERC20/ERC721/ERC1155），通常具备以下属性：

| 属性名        | 含义说明                                                                 |
|---------------|--------------------------------------------------------------------------|
| `name`        | 代币名称，如 `MyToken`                                                  |
| `symbol`      | 代币符号，类似股票代码，如 `MTK`                                        |
| `decimals`    | 精度，定义最小单位（通常 ERC20 是 18 位）                               |
| `totalSupply` | 总发行量                                                                 |
| `balanceOf()` | 查询账户地址拥有的代币数量                                               |
| `owner`       | 初始持有者或项目方地址                                                  |
| `transfer()`  | 转账功能，允许地址间转移代币                                            |

---

## 🚀 二、常见代币标准（以太坊生态）

### ✅ ERC20：可替代代币（Fungible Token）标准

- **定义**：标准化同质化资产，每单位等价，可用于流通或支付。
- **用途**：稳定币（USDT）、项目币（UNI）、空投积分。
- **核心函数**：

```solidity
totalSupply()
balanceOf(address)
transfer(address, uint256)
approve(address, uint256)
allowance(address, address)
transferFrom(address, address, uint256)
````

---

### ✅ ERC721：非同质化代币（NFT）标准

* **定义**：唯一资产的标准表示方式，每个 Token 有独立的 ID。
* **用途**：数字藏品、链上身份、门票、证书。
* **核心函数**：

```solidity
ownerOf(tokenId)
balanceOf(owner)
approve(to, tokenId)
safeTransferFrom(from, to, tokenId)
tokenURI(tokenId)
```

---

### ✅ ERC1155：混合代币标准（Multi-token）

* **定义**：支持可替代 + 不可替代资产的批量管理。
* **用途**：游戏道具批量发售、组合资产、低 gas NFT 应用。
* **核心函数**：

```solidity
balanceOf(address, id)
balanceOfBatch(address[], id[])
safeTransferFrom(from, to, id, amount, data)
uri(tokenId)
```

---

## 🧠 三种标准对比总结

| 特性       | ERC20 | ERC721  | ERC1155  |
| -------- | ----- | ------- | -------- |
| 是否可替代    | ✅ 是   | ❌ 否     | ✅ ✅ 支持两种 |
| 是否唯一     | ❌ 否   | ✅ 是     | ✅（支持可选）  |
| 是否支持批量转账 | ❌ 否   | ❌ 否     | ✅ 是      |
| 是否节省 gas | 一般    | ❌ 昂贵    | ✅ 更高效    |
| 常见用途     | 币、投票  | NFT、收藏品 | 游戏、组合资产  |

---

## 🔍 其他 Token 类型分类（按用途）

| 类型                    | 描述                      | 示例                     |
| --------------------- | ----------------------- | ---------------------- |
| Utility Token 实用型代币   | 用于平台服务访问，如打折、激励、权限等     | UNI, MATIC, BNB        |
| Governance Token 治理代币 | 用于参与 DAO 投票和治理治理事务      | COMP, AAVE, ENS        |
| Security Token 证券代币   | 类似证券，代表股份、债权，通常需要监管许可   | tZERO, Securitize      |
| Stablecoin 稳定币        | 与美元等法币挂钩，价格稳定           | USDC, USDT, DAI        |
| Payment Token 支付代币    | 用于支付手段，作为交易媒介           | BTC, LTC, DOGE         |
| Reward Token 激励代币     | 用于空投、挖矿、任务奖励等           | CAKE, SUSHI            |
| NFT 非同质化代币            | 唯一资产标识，常用于艺术品、游戏道具、数字身份 | CryptoPunks, BAYC, ENS |

---

## 🔧 拓展类型

| 类型                   | 定义                                  | 示例          |
| -------------------- | ----------------------------------- | ----------- |
| Wrapped Token 包装代币   | 1:1 锚定资产的镜像，如 WBTC 是 BTC 的 ERC20 版本 | WBTC, WETH  |
| Synthetic Token 合成资产 | 合成的可交易标的，通常反映某种外部资产价格，如股票、黄金        | sUSD, sTSLA |

---

## ✅ 推荐选择指南

| 场景                | 推荐标准    |
| ----------------- | ------- |
| 发平台币、积分、激励系统      | ERC20   |
| 发数字艺术 NFT、门票、证书等  | ERC721  |
| 发游戏内多个资产（金币 + 道具） | ERC1155 |
| 大量铸造 NFT、组合道具发行   | ERC1155 |
| DAO 治理 / 投票 / 投资  | ERC20   |