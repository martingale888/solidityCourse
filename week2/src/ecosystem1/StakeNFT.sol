// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC721} from "openzeppelin-contracts/token/ERC721/IERC721.sol";
import {IERC721Receiver} from "openzeppelin-contracts/token/ERC721/IERC721Receiver.sol";

import "./RewardERC20Token.sol";

contract StakeNFT is IERC721Receiver{
    RewardERC20Token private immutable _erc20;
    mapping(address => uint256) private _lastWithdraw;
    mapping(address=> uint256) private _cumWithdraw;

    mapping(address=>mapping(uint256=>address)) private _originalOwner;

    constructor(){
        _erc20 = new RewardERC20Token();
    }

    function onERC721Received(address, address from, uint256 tokenId, bytes calldata) external returns (bytes4) {
        require(block.timestamp - _lastWithdraw[msg.sender] >= 1 days && _cumWithdraw, "10 ether withdraw / 24 hr");
        _lastWithdraw[from] = block.timestamp;
        _cumWithdraw[from] = 0;     //how to control the amount here? does it have to be 10 ether each time?
        
        _originalOwner[msg.sender][tokenId] = from;     //who is from here? the contract that mint ERC20?

        uint256 _amount = 10 * 10**_erc20.decimals();
        _erc20.mint(from, _amount);
        return IERC721Receiver.onERC721Received.selector;       //what does this return? have to return selector, but what does return selector do?
    }

    functio withdrawNFT(address nft, uint256 tokenId) external {
        require(_originalOwner[nft][tokenId] == msg.sender,"only owner can withdraw");
        delete _originalOwner[nft][tokenId];
        IERC721(nft).safeTransferFrom(address(this),msg.sender,tokenId);
    }


}