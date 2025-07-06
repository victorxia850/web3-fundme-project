//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMeSimple02{

    
    uint256 constant MINIMUM_VALUE_USD = 1 ; // 投资人每次 fund 最低是 100 USD

    uint256 constant TARGET_USD = 5 ; // 筹款目标金额 1000 USD

    mapping(address => uint256) public funder2Amount;

    address public owner;

    uint256 public deploymentTimestamp;

    uint256 public lockTime;

    AggregatorV3Interface internal dataFeed;

    constructor(uint256 _lockTime){
        owner = msg.sender;
        lockTime = _lockTime;
        deploymentTimestamp = block.timestamp;
       dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    /*
     @notice 投资人投资:  投资人转入USD到合约中
        1. 此函数操作人是投资人，并不一定是 Owner
        2. 此操作需要在窗口内操作
        3. 投资人的转入金额至少为 100 USD
     */
    function fund() external payable { 

        // 1. more that the MINIMUM_VALUE
        require(eth2Usd(msg.value) >= MINIMUM_VALUE_USD, "Send more USD, the minimum value is 100 USD");

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

        // 3. the contract`s all should be more than the TARGET_USD
        require(eth2Usd(address(this).balance) >= TARGET_USD, "Target not reach");

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

        // 2. the contract`s all should be less than the TARGET_USD
        require(eth2Usd(address(this).balance) < TARGET_USD, "Target is reached");

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


    /*
    ethAmount( wei): 当用户输入 1TEH 时，合约中显示的数据却是 10 ** 18， 其实合约内部为了ETH数量的精度会把数据转换为 wei
    ETH -> USD precision = 10 ** 8
    */
    function eth2Usd(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        return (ethPrice * ethAmount) / (10 **18) / (10 ** 8) ;
    }

    function getLatestPrice() public view returns (int) {
        (, int price, , , ) = dataFeed.latestRoundData();
        return price / 1e8; // 默认已包含 8 位小数
    }

     function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }


}