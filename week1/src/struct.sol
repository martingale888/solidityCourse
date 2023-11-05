// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.18;

contract StructExample{

    struct Foo{
        uint256 a;
        uint256 b;
    }

    Foo public foo;
}

contract DepositOnly{
    mapping(address => string) public name;
    mapping(address => uint256) public balance;

    function deposit( string memory _name ) external payable{
        balance[msg.sender] += msg.value;
        name[msg.sender]= _name;
    }
}

contract DepositStruct{
    struct Person{
        string name;
        uint256 balance;
    }

    mapping(address => Person) public depositor;

    Person[] public arrayPerson;

    function deposit(string memory _name) external payable{
        depositor[msg.sender] = Person(_name, msg.value);
    }

    function addPersonToArray(string memory _name, uint256 _balance ) public {
        arrayPerson.push(Person(_name,_balance));
    }

    function readPersonFromArray(uint256 _index) public view returns (Person memory){
        return arrayPerson[_index];
    }

    function readPersonName(uint256 _index) public view returns(string memory){
        return arrayPerson[_index].name;
    }

    function readPersonBalance(uint256 _index) public view returns(uint256){
        return arrayPerson[_index].balance;
    }

    function setPersonAtIndex(uint256 _index, string memory _name, uint256 _balance) public{
        arrayPerson[_index] = Person(_name,_balance);
    }
}

contract BuyTickets{

    uint256 public constant TICKET_PRICE = 0.01 ether;

    struct Ticket{
        string name;
        uint256 numberOfTickets;
    }

    mapping(address => Ticket) public tickets;

    function buyTicket(string memory _name, uint256 _numberOfTickets) external payable{
        require(msg.value == _numberOfTickets * TICKET_PRICE, "wrong value");
        require(_numberOfTickets <= 10, "Max limit exceeded");
        require(tickets[msg.sender].numberOfTickets + _numberOfTickets <= 10, "max limit exceed");

        tickets[msg.sender].name = _name;
        tickets[msg.sender].numberOfTickets += _numberOfTickets;
    }

    function displayTickets(address _ticketHolder) external view returns(Ticket memory){
        return tickets[_ticketHolder];
    }
}