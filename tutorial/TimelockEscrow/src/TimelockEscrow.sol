// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    mapping(address => uint256) escrowAmount;
    mapping(address => uint256) dealTime;
    uint256 threeDays = 60 * 60 * 24 * 3;
    
    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        require(escrowAmount[msg.sender] == 0,"previous escrow hasn't been withdrawn yet");
        escrowAmount[msg.sender] = msg.value;
        dealTime[msg.sender] = block.timestamp;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(block.timestamp > dealTime[buyer] + threeDays ,"3 days before seller can withdraw escrow");
        (bool success,) = seller.call{value:escrowAmount[buyer]}("");
        escrowAmount[buyer]  = 0;
        require(success,"seller withdraw failed");
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        require(block.timestamp < dealTime[msg.sender] + threeDays ,"3 days has passed for buy to withdraw escrow");
        (bool success,) = msg.sender.call{value:escrowAmount[msg.sender]}("");
        escrowAmount[msg.sender] = 0;
        require(success,"buyer withdraw failed");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return escrowAmount[buyer];
    }
}
