// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CallingContract{
    function ask2(address source) public returns(uint256){
        //(bool ok, bytes memory result) = source.call(abi.encodeWithSignature("meaningOfLifeAndAllExistence()"));
        AnotherContract c = new AnotherContract();
        bytes memory result = new bytes(c.meaningOfLifeAndAllExistence());
        bool ok = true;
        require(ok,"call failed");

        return abi.decode(result,(uint256));
    }

    function ask(address source) public returns(uint256){
        (bool ok, bytes memory result) = source.call(abi.encodeWithSignature("meaningOfLifeAndAllExistence()"));
        require(ok,"call failed");
        return 0;
    }
        
    function callAdd(address source, uint256 x, uint256 y) public returns(uint256){
        (bool ok, bytes memory result) = source.call(abi.encodeWithSignature("Add(uint256 x, uint256 y)", x, y));
        require(ok,"call failed");

        uint256 sum = abi.decode(result, (uint256));
        return sum;
    }
}

//0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8
contract AnotherContract {
    function meaningOfLifeAndAllExistence() public pure returns( uint256){
        return 42;
    }

    function Add(uint256 x, uint256 y) public returns(uint256) {
        return x + y;
    }
}