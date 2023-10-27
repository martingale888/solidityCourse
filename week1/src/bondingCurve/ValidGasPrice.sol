// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "openzeppelin-contracts/access/Ownable.sol";
contract ValidGasPrice is Ownable{
    uint256 maxGasPrice = 10**18;

    modifier ValidGasPrice() {
        require(tx.gasprice <= maxGasPrice,"gas price must not be bigger than max gas price to prevent attach");
        _;
    }
    function setNewMaxGasPrice(uint256 newMaxGasPrice) public onlyOwner{
        maxGasPrice = newMaxGasPrice;
    }
}