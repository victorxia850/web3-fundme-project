核心功能（Core Features）

✅ 1. 创建收款函数（Create a Funding Function）

投资人可以通过该函数向合约发送资金（ether）进行投资

所有投资金额将自动计入项目总筹资金额中

Investors can contribute Ether to the crowdfunding campaign using a designated funding function. All contributions are automatically added to the total raised amount.

✅ 2. 记录与查询投资人（Record and Query Investors）

合约会记录每一位投资人的地址与对应投资金额

提供接口查询当前所有投资人及其投资详情

The contract maintains a record of each investor's address and the corresponding amount they contributed. Public functions allow querying investor information.

✅ 3. 达标提款机制（Withdraw Funds if Goal is Reached）

如果在锁定期内筹集到目标金额，发起人（即生产商）可以提款

提款仅限项目设定的目标已完成时

If the fundraising goal is met within the defined lock-in period, the project owner is allowed to withdraw the funds. This ensures funds are only used when the goal is achieved.

✅ 4. 未达标退款机制（Refund if Goal is Not Reached）

如果在锁定期结束前未达成目标金额，投资人可在锁定期结束后申请退款

合约将返还其原始投资金额

If the funding goal is not reached by the end of the lock-in period, investors are eligible to claim a refund. Each investor can retrieve the exact amount they contributed.

可扩展性建议（Extensibility Suggestions）

支持多个众筹轮次（Multi-round crowdfunding）

增加时间锁或分期付款机制（Vesting/Time-lock for withdrawals）

支持投资人投票控制资金流向（DAO-like governance）