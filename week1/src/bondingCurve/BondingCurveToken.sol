// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import  "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import {PullPayment} from "openzeppelin-contracts/contracts/security/PullPayment.sol";
import {LinearBondingCurve} from "./LinearBondingCurve.sol";
import {ValidGasPrice} from "./ValidGasPrice.sol";

error TransferFailed();

contract BondingCurveToken is ERC20, PullPayment, ValidGasPrice,LinearBondingCurve {
    using SafeMath for uint256;

    uint256 internal reserveBalance;
    uint256 internal supply;
    uint256 internal N_PLUS_1;

    event BCTMint(address _address, uint256 continuousTokenAmount, uint256 reserveTokenAmount);

    event BCTSell(address _address, uint256 reserveTokenAmount, uint256 continuousTokenAmount);

    constructor(uint256 _N_PLUS_1) ERC20("BondingCurveToken","BCT"){
        reserveBalance = 0.5 ether;
        supply         = 0.5;
        N_PLUS_1       = _N_PLUS_1;
        _mint(msg.sender, 0.5 * decimals());
    }

    //why we still need to create this mint()? 
    function mint() public payable returns(uint256) {
        require(msg.value > 0,"must send ether to buy tokens");
        // return _BCTMint(msg.value);
        uint256 amount = calculatePurchaseReturn( supply, reserveBalance, N_PLUS_1, msg.value);
        // _mint(msg.sender, amount);
        bool success = address(this).transferFrom(msg.sender, address(this), msg.value);        //do we need this?
        if (success){
            reserveBalance = reserveBalance.add(msg.value);      // why not use reserveBalance + msg.value ?
            supply += amount;
            emit BCTMint(msg.sender, amount, msg.value);
            return amount;
        } else {
            require(false,"mint failed");
        }
    }

    function sell() public payable returns(uint256) {
        require(msg.value > 0, "Amount must be positive ");
        require(balanceOf(msg.sender) >= msg.value, "Insufficient token to sell");

        uint256 returnAmount = calculateSaleReturn(supply, reserveBalance, N_PLUS_1, msg.value);

        bool success = address(this).transferFrom(msg.sender, address(this), msg.value);
        if (success) {
            supply -= msg.value;
            reserveBalance -= returnAmount;
            emit BCTSell(msg.sender, returnAmount, msg.value);
            return returnAmount;
        } else {
            require(false,"sale failed");
        }

    }


    /**
     * To avoid reentrancy attacks
     * reference: https://docs.openzeppelin.com/contracts/4.x/api/security#PullPayment
     */
    function withdrawRefund() external {
    require(
        payments(msg.sender) > 0,
        "You don't have any balance to withdraw."
    );

    withdrawPayments(payable(msg.sender));
}
}
    