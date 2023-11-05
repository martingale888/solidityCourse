// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.18;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20("someToken","ST"){}

contract Parent1{
    string private name;

    constructor(string memory _name){
        name = _name;
    }
    //must be virtual
    function meaning() public pure virtual returns(uint256){
        return 42;
    }
}

contract Parent2{
    //must be virtual
    function meaning() public pure virtual returns(uint256){
        return 22;
    }
}
contract Child is Parent1("myname") {

    function meaning() public pure override returns(uint256){
        return super.meaning();
    }
}