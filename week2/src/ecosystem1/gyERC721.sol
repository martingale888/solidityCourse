// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";
import {ERC721Royalty} from "openzeppelin-contracts/token/ERC721/extensions/ERC721Royalty.sol";
import {BitMaps} from "openzeppelin-contracts/utils/structs/BitMaps.sol";
import {Ownable2Step} from "openzeppelin-contracts/access/Ownable2Step.sol";

contract gyERC721 is ERC721Royalty, Ownable2Step {
    using BitMaps for Bitmaps.BitMap;

    uint256 private _currentSupply;
    uint256 public constant presalePrice=0.5 ether;
    uint256 public constant regularPrice=0.5 ether;

    bytes32 private merkleRoot;
    BitMaps.BitMap private ticketMap;

    constructor(bytes32 _merkleRoot) ERC721("gyToken","GT"){
        _setDefaultRoyalty(owner(), 250);
        merkleRoot = _merkltRoot;
    }

    //who update or create merkleRoot?
    function updateMerkleRoot(bytes32 _newRoot) external onlyOwner {
        merkleRoot = _newRoot;
    }

    function withdraw() external onlyOwner{
        (bool success) = owner().call{value:address(this).balance}("");     //do we need to update balance in contract gyERC721 like ticketMap?
        require(success);
        lastWithdraw[msg.sender] = block.timestamp;
    }

    function royaltyInfo(uint256 tokenId,uint256 salePrice) public view override returns (address, uint256){
        require(_exists(tokenId),"token do not exist");
        return super.royaltyInfo(tokenId, salePrice);
    }

    function _isClaimed(uint256 ticketNum) internal view returns(bool){
        return BitMaps.BitMap.get(ticketMap,ticketNum);     //is this right?
    }

    function _setClaim(uint256 ticketNum) internal {
        BitMaps.BitMap.set(ticketMap,ticketNum);
    }

    function presaleMint(address to, uint256 ticketNum, uint256 tokenId, bytes32[] calldata proof) external payable {
        require(_currentSupply<20,"max supply reached");
        require(msg.value ==presalePrice,"price need to be presalePrice");
        require(!_isClaimed(ticketNum),"ticketNum is already used");

        byte32 leaf = keccak256(abi.encodePacked(to, ticketNum, tokenId));
        require(MerkleProof.verify(proof,merkleRoot,leaf),"invalid merkle proof");
        
        _currentSupply++;
        _setClaim(ticketNum);
        _safeMint(to, tokenId);
    }

    function mint(address to, uint256 tokenId) external payable{
        require(_currentSupply < 20,"max supply reached");
        require(msg.value == regularPrice,"price need to be regularPrice");
        _currentSupply++;
        _safeMint(to, tokenId);
    }
}