// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract PresaleBenchmark {

    uint256 private constant MAX_INT = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    uint256[3] arr = [MAX_INT, MAX_INT, MAX_INT];

    function claimTicketOrBlockTransaction(uint256 ticketNumber) external {
        require(ticketNumber < arr.length * 256, "too large");
        uint256 storageOffset = ticketNumber / 256;
        uint256 offsetWithin256 = ticketNumber % 256;
        uint256 storedBit = (arr[storageOffset] >> offsetWithin256) & uint256(1);
        require(storedBit == 1, "already taken");

        arr[storageOffset] = arr[storageOffset] & ~(uint256(1) << offsetWithin256);
    }
}

contract DivTest {

  function div(uint256 a, uint256 b) public pure returns (uint256 q) {
    unchecked {
      q = a / b;
    }
  }
}

contract testRoyalty{
  uint256 private _constFeeDenominator = 10000;

  /*
   * 3268 gas
   */
  function constantNumber(uint256 salePrice, uint256 royaltyFraction) public view returns (uint256){
    return salePrice * royaltyFraction / _constFeeDenominator;
  }
  /*
   * 1224 gas
   */
  function fromFunction(uint256 salePrice, uint256 royaltyFraction) public pure returns (uint256){
    return salePrice * royaltyFraction / _feeDenominator();
  }

  function _feeDenominator() internal pure virtual returns (uint256) {
    return 10000;
  }
}