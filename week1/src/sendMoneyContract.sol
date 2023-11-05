// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract sendMoneyContract{
    constructor() payable{
    }

    function payMe() public payable{}

    function sendMoney(address receiverContract) public payable{
        uint256 amount = myBalance();
        (bool ok,) = receiverContract.call{value:amount}(abi.encodeWithSignature("takeMoney()"));
        require(ok, "transfer failed");

    }

    function sendMoney2(address receiverContract) public payable{
        uint256 amount = myBalance();
        receiverContract.call{value:amount}("");
    }

    function myBalance() public view returns(uint256){
        return address(this).balance;
    }
}

contract receiveEther{
    
    //receive can only be external, not public
    receive() external payable{}

    function withdraw() public payable{
        require(msg.sender==0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,"only 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 can withdraw");
        msg.sender.call{value:myBalance()};
    }

    //takeMoney must be payable, else transfer will revert.
    function takeMoney() public payable {}

    function myBalance() public view returns(uint256){
        return address(this).balance;
    }
}