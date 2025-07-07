//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FundTokenSimple01 {
    string public name;  // 通证的名称
    string public symbol; // 通证的简称
    uint256 public total; // 通证的发行数量
    address public owner; // 合约的拥有者
    mapping(address => uint256) public balances; // address => uint256 通证余额

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    // mint: 获取通证
    function mint(uint256 amountToMint) public {
        balances[msg.sender] += amountToMint;
        total += amountToMint;
    }

    // transfer: transfer 通证
    function transfer(address payee, uint256 amount) public {
        require(balances[msg.sender] >= amount, "You do not have enough balance to transfer");
        balances[msg.sender] -= amount;
        balances[payee] += amount;
    } 

    // balanceOf: 查看某一个地址的通证数量
    function balanceOf(address addr) public view returns(uint256) {
        return balances[addr];
    }

}