//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract FundMeSimple01{

    uint256 constant MINIMUM_VALUE_ETH = 1 * 10 ** 18 ; // 投资人每次 Fund 最低是 1 ETH

    uint256 constant TARGET_ETH = 5 * 10 ** 18  ; // 筹款目标金额 5 ETH

    mapping(address => uint256) public funder2Amount;

    address public owner;

    uint256 public deploymentTimestamp;

    uint256 public lockTime;

    constructor(uint256 _lockTime){
        owner = msg.sender;
        lockTime = _lockTime;
        deploymentTimestamp = block.timestamp;
    }

    /*
     @notice 投资人投资:  投资人转入USD到合约中
        1. 此函数操作人是投资人，并不一定是 Owner
        2. 此操作需要在窗口内操作
        3. 投资人的转入金额至少为 100 USD
     */
    function fund() external payable { 

        // 1. more that the MINIMUM_VALUE
        require(msg.value >= MINIMUM_VALUE_ETH, "Send more ETH, the minimum value is 1 ETH");

        // 2. should be in window time
        require(block.timestamp < deploymentTimestamp + lockTime, "Window is closed");

        // 3. record it in mapping
        funder2Amount[msg.sender] += msg.value;
    }

    /*
     @notice 众筹成功后，生产商可以提款:  合约中的所有金额全部都会转到生产商（合约Owner）
        1. 此函数只有生产商能操作，也就是合约Owner
        2. 此操作需要在窗口期结束后
        3. 筹款的合约金额达到目标值
     */
    function withdrawFunds() external { 

        // 1. only can be called by owner
        require(msg.sender == owner, "Only can be called by");

        // 2. should be not in window time
        require(block.timestamp >= deploymentTimestamp + lockTime, "Window is not closed");

        // 3. the contract`s all should be more than the TARGET_ETH
        require(address(this).balance >= TARGET_ETH, "Target not reach");

        // 4. all USD in contract will transfer to Owner
        // payable(msg.sender).transfer(address(this).balance);
        bool success;
        (success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Tx failed");

        // 5. why ? 
        funder2Amount[msg.sender] = 0 ;

    }

    
    /*
      @notice 众筹失败后，投资人可退款:  合约中的所有金额分别转回投资人
        1. 此函数操作人是投资人，并不一定是 Owner
        2. 此操作需要在窗口期结束后
        3. 筹款的合约金额没有达到目标值
     */
    function claimRefund() external {
        // 1. should be not in window time
         require(block.timestamp >= deploymentTimestamp + lockTime, "Window is not closed");

        // 2. the contract`s all should be less than the TARGET_ETH
        require(address(this).balance < TARGET_ETH, "Target is reached");

        // 3. you should fund before
        uint256 fundAmount = funder2Amount[msg.sender];
        require(fundAmount !=0, "There is not fund for you");

        // 4. refund for you
        bool success;
        (success, ) = payable(msg.sender).call{value: funder2Amount[msg.sender]}("");
        require(success, "Tx failed");

        // 5. your fund is 0 now
        funder2Amount[msg.sender] = 0 ;
    }

    /*
     @notice 转移 Owner 所有权
        1. 此函数只能由 Owner 执行
    */
    function updateOwnerShip(address newOwner) public {
        require(msg.sender == owner, "Only be called by owner");
        owner = newOwner;
    }
}