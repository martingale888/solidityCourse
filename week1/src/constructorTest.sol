// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ExampleContract{

    address public banker;

    constructor(address _banker) {
        banker = _banker;
    }
}

contract StringContract{

    string public name;

    constructor(string memory _name){
        name = _name;
    }
}