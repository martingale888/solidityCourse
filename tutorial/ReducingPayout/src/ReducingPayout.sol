// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;

    constructor() payable {
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        // your code here
        uint256 currentT = block.timestamp;
        uint256 remainingBalance;
        if (currentT < depositedTime + 24 * 60 * 60 && currentT >= depositedTime){
            remainingBalance = 1 ether - (currentT - depositedTime) * 11574 gwei ;
        }
        // require(currentT > depositedTime && currentT <= depositedTime + 24 * 60 * 60, "can only withdraw within 1 day window");
        // uint256 remainingBalance = 1 ether - 1 ether * (currentT - depositedTime)/(24*60*60) ;
        (bool success,) = msg.sender.call{value:remainingBalance}("");
        require(success,"withdraw failed");

    }
}
