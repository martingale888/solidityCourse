// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/SanctionTOken.sol";

contract SanctionTokenTest is Test {
    SanctionToken public sToken;

    function setUp() public {
        sToken = new SanctionToken("SanctionToken","ST",100);
    }

    function testSanctionedAddress() public {
        
        address goodFrom = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        address goodTo   = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
        address bannedFrom=0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
        address bannedTo = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2;

        uint256 amount = 2 ether;

        sToken.addBannedAddress(bannedFrom);
        sToken.addBannedAddress(bannedTo);
        vm.prank(bannedFrom);
        vm.expectRevert(bytes("expect to revert for from address in banned address"));
        sToken.transfer(msg.sender, goodTo, amount);

        vm.prank(goodFrom);
        vm.expectRevert(bytes("expect to revert for to address in banned address"));
        sToken.transfer(msg.sender, bannedTo, amount);

        vm.prank(goodFrom);
        vm.expectRevert(bytes("expect to transfer from goodFrom to goodTo"));
        sToken.transfer(msg.sender, goodTo, amount)

        
    }
}
