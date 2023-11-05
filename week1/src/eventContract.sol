// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract eventContract{
    event Deposit(address indexed depositor, uint256 amount);

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}