// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract RareCoin{

    address public source;

    function trade(uint256 amount) public{
        //0x2F8895b08D8F226b19895d46154faB7096fB2593,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,10
        (bool ok, bytes memory result) = source.call(abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, address(this), amount));
        require(ok,"call failed");
    }
}

contract CoinBalance{

    constructor() payable{

    }
    
    function payMe() public payable{

    }

    function howMuchEtherIHave() public view returns(uint256){
        return address(this).balance;
    }

    function balanceByAddress(address add) public view returns(uint256){
        return add.balance;
    }

    function senderBalance() public view returns( uint256 ){
        return msg.sender.balance;
    }
}