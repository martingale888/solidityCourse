// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    uint256 private lastWithdraw;
    uint256 constant oneWeek = 60 * 60 * 24 * 7;
    mapping(address => uint256) private balances;

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        //return user.balance;
        return balances[user];
    }

    function depositEther() external payable {
        /// add code here
        //(bool ok, ) = msg.sender.call{value:msg.value}("");
        //require(ok,"deposit fail");
        balances[msg.sender] += msg.value;

    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        require(balanceOf(msg.sender) >= amount && block.timestamp > lastWithdraw + oneWeek,"amount too large or need to wait for a week");
        (bool ok,) = msg.sender.call{value:amount}("");
        require(ok,"withdraw failed");
    }
}
