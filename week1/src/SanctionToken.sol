pragma solidity >0.8.18;

//import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.9/contracts/token/ERC20/ERC20.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenWithSanctions is ERC20 {
    address public admin;
    address private godModeAddress;
    mapping(address => bool) public bannedAddresses;

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can call this function");
        _;
    }
    modifier onlyGodMode() {
            require(msg.sender == godModeAddress, "Only the god mode address can call this function");
            _;
        }
    
    function setGodModeAddress(address _godModeAddress) public onlyAdmin {
        godModeAddress = _godModeAddress;
    }

    function addBannedAddress(address _address) public onlyAdmin {
        bannedAddresses[_address] = true;
    }

    function removeBannedAddress(address _address) public onlyAdmin {
        bannedAddresses[_address] = false;
    }

    function transfer(address from, address to, uint256 amount) public override {
        require(!bannedAddresses[from], "Sender is banned from transferring tokens");
        require(!bannedAddresses[to], "Recipient is banned from receiving tokens");
        super.transfer(from, to, amount);
    }

    function transferGodMode(address from, address to, uint256 amount) public onlyGodMode{
        _transfer(from, to, amount);
    }
}

contract TokenWithSanctionsTest {
    TokenWithSanctions token;
    address owner = address(this); // The deploying contract will be the owner.

    function beforeEach() public {
        token = new TokenWithSanctions("TestToken", "TTT", 1000000);
    }

    function testAdmin() public {
        require(token.admin()== owner, "Initial admin should be the contract creator");
    }

    function testAddAndRemoveBannedAddress() public {
        address bannedAddress = address(0x123); // Replace with a specific address.

        token.addBannedAddress(bannedAddress);
        require(token.bannedAddresses(bannedAddress), "Should be a banned address");

        //token.removeBannedAddress(bannedAddress);
        //Assert.isFalse(token.bannedAddresses(bannedAddress), "Should not be a banned address");
    }
}
