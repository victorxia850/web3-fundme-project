## 🔧 核心功能（Core Features）

### ✅ 1. 创建收款函数（Create a Funding Function）

投资人可以通过合约的特定函数发送 ETH 参与投资。  
所有捐赠金额会自动计入项目的总筹资金额中。

> Investors can contribute Ether to the crowdfunding campaign using a designated funding function.  
> All contributions are automatically added to the total raised amount.

---

### ✅ 2. 记录与查询投资人（Record and Query Investors）

合约会记录每一位投资人的地址及其投资金额，并提供接口以供查询。

> The contract maintains a record of each investor's address and the corresponding amount they contributed.  
> Public functions allow querying investor information.

---

### ✅ 3. 达标提款机制（Withdraw Funds if Goal is Reached）

若在锁定期内达成目标金额，合约发起人（项目方）可进行提款。  
提款操作受到条件约束，仅在目标达成后允许执行。

> If the fundraising goal is met within the defined lock-in period, the project owner is allowed to withdraw the funds.  
> This ensures funds are only used when the goal is achieved.

---

### ✅ 4. 未达标退款机制（Refund if Goal is Not Reached）

如果在锁定期结束前未能达成目标金额，投资人可在结束后发起退款申请。  
合约将自动退还其原始投资金额，确保资金安全。

> If the funding goal is not reached by the end of the lock-in period, investors are eligible to claim a refund.  
> Each investor can retrieve the exact amount they contributed.

---

## 🔮 可扩展性建议（Extensibility Suggestions）

- 支持多个众筹轮次（Multi-round crowdfunding）  
- 增加时间锁或分期付款机制（Vesting / Time-lock for withdrawals）  
- 引入投资人投票控制资金用途的机制（DAO-like governance）  

