// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import  "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import {PullPayment} from "openzeppelin-contracts/contracts/security/PullPayment.sol";
import {LinearBondingCurve} from "./LinearBondingCurve.sol";
import {ValidGasPrice} from "./ValidGasPrice.sol";
import "lib/erc1363-payable-token/contracts/token/ERC1363/ERC1363.sol";

error TransferFailed();

contract BondingCurveToken is ERC20, ERC1363, PullPayment, ValidGasPrice,LinearBondingCurve {
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

    // function _BCTMint(uint256 _deposit) internal returns (uint256){
    //     require(_deposit > 0, "Deposit must be non-zero.");

    //     uint256 amount = calculatePurchaseReturn( supply, reserveBalance, N_PLUS_1, _deposit);
    //     _mint(msg.sender, amount);
    //     reserveBalance = reserveBalance.add(_deposit);      // why not use reserveBalance + _deposit ?
    //     emit BCTMint(msg.sender, amount, _deposit);
    //     return amount;
    // }
    /**
     * Users can buy tokens for themselves by sending ETH directly to this contract.
     */
    // receive() external payable {
    //     _buy(msg.sender, msg.value);
    // }

    // function _buy(address buyer, uint256 amount) internal ValidGasPrice {
    //     require(amount > 0, "Deposit must be non-zero.");

    //     uint256 tokenReward = calculatePurchaseReturn(totalSupply(),reserveBalance, N_PLUS_1, amount);

    //     _mint(buyer, tokenReward);
    //     reserveBalance += amount;
    // }

    // /**
    //  * Users can also buy tokens for thmeselves or other users
    //  *   by calling this function with different `buyer` address.
    //  */

    // function buy(address buyer) external payable {
    //     _buy(buyer, msg.value);
    // }

    // function _sell(address tokenOwner,uint256 amount,address payee) internal ValidGasPrice {
    //     require(amount >0,"Amount must be positive");

    //     uint256 refundAmount = calculateSaleReturn(totalSupply(), reserveBalance, N_PLUS_1,amount);
    //     _burn(tokenOwner, amount);
    //     reserveBalance -= refundAmount;

    //     _asyncTransfer(payee, refundAmount);
    // }

    // /**
    //  * Users can sell their own tokens by calling this function directly.
    //  */
    // function sell(uint256 amount) external {
    //     require(balanceOf(msg.sender) >= amount, "Not enough tokens to sell.");

    //     _sell(msg.sender, amount, msg.sender);
    // }

    // /**
    //  * Users can sell their allwance tokens by calling this function.
    //  * User can also specify who can receive the benefit
    //  */
    // function sell(address tokenOwner, uint256 amount, address payee) external {
    //     require(
    //         allowance(tokenOwner, msg.sender) >= amount,
    //         "Not enough tokens to sell."
    //     );

    //     _sell(tokenOwner, amount, payee);
    // }

    //     /**
    //  * Users can also sell their own tokens by transferring tokens to this contract
    //  *  through `transferAndCall`
    //  *
    //  * Users can also sell other users' tokens by transferring tokens to this contract
    //  *  through `transferFromAndCall` while they have approval
    //  *
    //  * This function is called after transfer()
    //  * So when onTransferReceived() is executed:
    //  *    balanceOf(from) = balanceOf(from) - amount
    //  *    balanceOf(address(this)) = balanceOf(address(this)) + amount
    //  */
    // function onTransferReceived(
    //     address operator,
    //     address from,
    //     uint256 value,
    //     bytes calldata
    // ) external returns (bytes4) {
    //     _sell(address(this), value, operator);

    //     return IERC1363Receiver.onTransferReceived.selector;
    // }


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
    