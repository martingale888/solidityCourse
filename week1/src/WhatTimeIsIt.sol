// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract WhatTimeIsIt{

    function timestamp() public view returns(uint256){
        return block.timestamp;
    }

    uint256 public lastCall;

    function hasCooldown() public{
        uint256 day = 60 * 60 * 24;
        require(block.timestamp > lastCall + day,"hasn't been a day yet");
        lastCall = block.timestamp;
    }

    function blockNumber() public view returns(uint256){
        return block.number;
    }

    uint256 private calledAt;

    function callMeFirst() external {
        calledAt = block.number;
    }

    function callMeSecond() external {
        require(calledAt != 0 && block.number > calledAt,"callMeFirst() not called");
    }
}