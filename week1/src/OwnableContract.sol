// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.18;

contract Ownable{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"only owner");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner{
        owner = newOwner;
    }
}

contract HoldFunds is Ownable{

    function withdrawFunds() public onlyOwner{
        (bool ok, ) = owner.call{value:address(this).balance}("");
        require(ok,"transfer failed");
    }

    receive() external payable{}
}