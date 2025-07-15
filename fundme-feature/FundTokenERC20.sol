//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FundMe} from "./FundMe.sol";

contract FundTokenERC20 is ERC20{

     FundMe fundMe;

    constructor(address fundMeAddr) ERC20 ("FundTokenERC20", "FT") {
        fundMe = FundMe(fundMeAddr);
    }

    /*
    funder 可以领取 Token:
        1. 领取的 Token 不能超过其 fund 的金额数额
        1. 领取的 Token 的前提是合约需要众筹成功，也就是生产商提款成功， 合约中的所有金额全部都会转到生产商（合约Owner）
    */
    function mint(uint256 amountToMint) public {
        require(fundMe.getFundSuccess(), "The fundme is not completed yet");
        require(fundMe.funder2Amount(msg.sender) >= amountToMint, "You cannot mint those many ERC20 tokens");
        _mint(msg.sender, amountToMint);
        fundMe.setFunderToAmount(msg.sender, fundMe.funder2Amount(msg.sender) - amountToMint);
    }

    /*
    funder 可以 transfer Token, ERC20 合约中有该方法
    */


    /*
    funder 使用完后需要 burn Token
    */
    function claim(uint256 amountToClaim) public {
        require(balanceOf(msg.sender) > amountToClaim, "You don't have enough ERC20 tokens");
        // todo: You can add some code here;
        _burn(msg.sender, amountToClaim);
    }

}