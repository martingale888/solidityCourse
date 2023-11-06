
// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ERC20 {
    string public name;
    string public symbol;

    mapping(address => uint256) public balanceOf;
    address public owner;
    uint8 public decimals;

    uint256 public totalSupply;
    uint256 public constant maxSupply = 1000000;
    // owner -> spender -> allowance
        // this enables an owner to give allowance to multiple addresses
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        decimals = 18;

        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "only owner can create tokens");
        require(totalSupply+amount < maxSupply,"max token in supply is 1 million");
        totalSupply += amount;
        balanceOf[owner] += amount;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        return helperTransfer(msg.sender, to, amount);
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;

        return true;
    }

    // just added
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        if (msg.sender != from) {
            require(allowance[from][msg.sender] >= amount, "not enough allowance");

            allowance[from][msg.sender] -= amount;
        }

        return helperTransfer(from, to, amount);
    }


    // it's very important for this function to be internal!
    function helperTransfer(address from, address   to, uint256 amount) internal returns (bool) {
        require(balanceOf[from] >= amount, "not enough money");
        require(to != address(0), "cannot send to address(0)");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        return true;
    }
}

contract abiExample{
    //0x92d62db5
    function meaningOfLifeAndAllExistence() public pure returns(uint256){
        return 42;
    }

    //0xd8846858
    function meaningOfLifeAndAllExistenceBytes() public pure returns(bytes memory){
        return msg.data;
    }

    //0xa91fd9600000000000000000000000000000000000000000000000000000000000000001
    function meaningOfLifeAndAllExistenceArgument(uint256 x) public pure returns(bytes memory){
        return msg.data;
    }

    function getEncoding(uint256 x) public pure returns (bytes memory){
        return abi.encodeWithSignature("meaningOfLifeAndAllExistenceArgument", x);
    }

    function encodingXY(uint x, uint256 y) public pure returns( bytes memory ) {
        return abi.encode(x,y);
    }

    function getATuple(bytes memory encoding) public pure returns(uint256, uint256){
        (uint256 x, uint256 y) = abi.decode(encoding, (uint256, uint256));
        return (x,y);
    }
}