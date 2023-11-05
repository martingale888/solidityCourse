// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.18;

interface IAdder{
    function add(uint256, uint256) external view returns (uint256);
}

contract Adder{
    uint256 private change;
    function add(uint256 a, uint256 b) public returns (uint256) {
        change = 5;
        return a + b + change;
    }
}

contract getSumV2 {

    function getSum(IAdder adder, uint256 a, uint256 b) public returns (uint256) {
        adder.add(a,b);
    }
}

contract getSumV1{
    function getSum(address adder, uint256 a, uint256 b) external view returns (uint256) {
        //staticcall will revert if add() changes state variable.
        (bool ok, bytes memory result) = adder.staticcall(abi.encodeWithSignature("add(uint256,uint256)", a,b));
        require(ok,"call failed");
        uint256 sum = abi.decode(result,(uint256));
        return sum;
    }
}