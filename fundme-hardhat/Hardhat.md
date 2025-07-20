Hardhat 是一个用于以太坊智能合约开发的强大开发环境，主要用于 Solidity 合约的编写、编译、测试、部署和调试。它类似于 Node.js 的开发工具（如 Webpack、Babel、Jest 等），为 Solidity 开发者提供了一整套开发工具链。

---

## 一、Hardhat 的核心功能

1. **本地以太坊网络（Hardhat Network）**
   - 可以快速部署和测试合约。
   - 支持 fork 主网/测试网，便于调试。
   - 快速交易确认，支持时间控制。

2. **合约编译**
   - 支持多个 Solidity 版本。
   - 支持自动编译。

3. **测试**
   - 支持使用 JavaScript/TypeScript 编写测试用例。
   - 支持 Mocha 和 Chai 测试框架。
   - 提供丰富的断言和模拟功能。

4. **脚本部署**
   - 支持使用 JavaScript/TypeScript 编写部署脚本。
   - 支持多网络部署（本地、测试网、主网等）。

5. **调试能力**
   - 提供详细的错误日志和堆栈跟踪。
   - 支持 Solidity 调试器。

6. **插件生态**
   - 插件丰富，如 Hardhat Etherscan 验证、Hardhat Ignite、Hardhat Defender 等。

---

## 二、安装 Hardhat

### 1. 初始化项目

```bash
mkdir my-hardhat-project
cd my-hardhat-project
npm init --yes
npm install --save-dev hardhat
```

### 2. 创建 Hardhat 项目

```bash
npx hardhat
```

选择 `Create a JavaScript project` 或 `Create a TypeScript project`，然后按照提示操作。

---

## 三、项目结构

一个典型的 Hardhat 项目结构如下：

```
my-hardhat-project/
├── contracts/             # Solidity 合约
├── scripts/               # 部署脚本
├── test/                  # 测试脚本
├── hardhat.config.js      # 配置文件
└── README.md
```

---

## 四、常用命令

### 1. 编译合约

```bash
npx hardhat compile
```

### 2. 运行测试

```bash
npx hardhat test
```

### 3. 运行单个测试文件

```bash
npx hardhat test test/MyTest.js
```

### 4. 运行脚本

```bash
npx hardhat run scripts/deploy.js
```

### 5. 启动本地节点

```bash
npx hardhat node
```

### 6. 部署合约到指定网络

```bash
npx hardhat run scripts/deploy.js --network localhost
npx hardhat run scripts/deploy.js --network goerli // other
```


## 五、配置文件 `hardhat.config.js`

示例配置文件：

```js
require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {}, // 默认本地网络
    goerli: {
      url: "https://goerli.infura.io/v3/YOUR_INFURA_PROJECT_ID",
      accounts: ["YOUR_PRIVATE_KEY"],
    },
  },
};
```

---

## 六、部署合约示例

`scripts/deploy.js` 示例：

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const MyContract = await ethers.getContractFactory("MyContract");
  const myContract = await MyContract.deploy();

  await myContract.deployed();

  console.log("MyContract deployed to:", myContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

运行部署脚本：

```bash
npx hardhat run scripts/deploy.js --network goerli
```

---

## 七、测试合约示例（使用 Mocha）

`test/MyTest.js` 示例：

```js
const { expect } = require("chai");

describe("MyContract", function () {
  let myContract;

  beforeEach(async function () {
    const MyContract = await ethers.getContractFactory("MyContract");
    myContract = await MyContract.deploy();
    await myContract.deployed();
  });

  it("should return the correct value", async function () {
    const value = await myContract.myFunction();
    expect(value).to.equal(42);
  });
});
```

---

## 八、常见插件推荐

| 插件 | 功能 |
|------|------|
| `@nomicfoundation/hardhat-toolbox` | 包含 Hardhat Ethers、Waffle、Chai、Mocha 等 |
| `hardhat-gas-reporter` | 测试时显示 gas 消耗 |
| `solidity-coverage` | 合约测试覆盖率 |
| `hardhat-deploy` | 支持可复用的部署脚本 |
| `@nomiclabs/hardhat-etherscan` | 合约源码验证（如 Etherscan） |

安装插件示例：

```bash
npm install --save-dev hardhat-gas-reporter
```

然后在 `hardhat.config.js` 中引入：

```js
require("hardhat-gas-reporter");

module.exports = {
  gasReporter: {
    enabled: true,
  },
};
```

---

## 九、调试合约

使用 Hardhat 的调试器：

```bash
npx hardhat debug scripts/deploy.js
```

也可以在合约中添加 `revert` 错误信息或使用 `console.log()`（需安装 `hardhat/console.sol`）：

```solidity
import "hardhat/console.sol";

console.log("Value is:", value);
```

---

## 十、资源推荐

- [Hardhat 官方文档](https://hardhat.org/docs)
- [Solidity 官方文档](https://docs.soliditylang.org/)
- [Hardhat GitHub](https://github.com/NomicFoundation/hardhat)
- [Hardhat + React 项目模板（Hardhat Box）](https://github.com/scaffold-eth/scaffold-eth)

---
