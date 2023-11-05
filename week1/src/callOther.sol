// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

contract caller{
    address public owner;

    constructor(){
        owner = msg.sender;
    }
    function callOther(callee called) public returns(address) {
        address calleeAddress = called.doSomething();
        return calleeAddress;
}    
}


contract callee{
    address public owner;
    address public callerAddress;
    constructor(){
        owner = msg.sender;
    }
    function doSomething() public returns(address _callerAddress) {
        callerAddress = _callerAddress;
        return msg.sender;
  // origin is the original initiator
  // msg.sender is the contract that called this. 
}
}
