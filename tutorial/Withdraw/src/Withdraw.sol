// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Withdraw {
    
    // @notice make this contract able to receive ether from anyone
    // and anyone can call withdraw below to withdraw all ether from it
    
    receive() external payable{}

    function withdraw() public payable{
        // your code here
        uint256 balance = myBalance();
        msg.sender.call{value:balance}("");
    }

    function myBalance() public view returns(uint256){
        return address(this).balance;
    }
}
