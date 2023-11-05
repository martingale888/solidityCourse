// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.18;

contract stringExample{

    function stringLengthFromBytes(string memory input) public pure returns (uint256){
        return bytes(input).length;
    }

    function stringToBytes(string memory input) public pure returns (bytes memory){
        return bytes(input);
    }

    function bytesToString(bytes memory input) public pure returns (string memory){
        return string(input);
    }

    function charOfString(string memory s, uint256 index) public pure returns(string memory){
        bytes memory char = new bytes(1);
        char[0] = bytes(s)[index];
        return string(char);
    }

        function charOfString2(string memory s, uint256 index) public pure returns(bytes memory){
        bytes memory char = new bytes(1);
        char[0] = bytes(s)[index];
        return char;
    }

    // function returnUnicodeChar(string memory s, uint256 index) public pure returns(string memory){
    //     bytes memory char = new bytes(1);
    //     char[0] = bytes(unicode(s))[idex];
    //     return char;
    // }

}

contract HexData{
    //helloworld : 68 65 6c 6c 6f 77 6f 72 6c 64 
    bytes hexData = hex"68656C6C6F776F726C64";

    function getString() public view returns(string memory){
        return string(hexData);
    }

    function getHex() public view returns(bytes memory){
        return hexData;
    }

    function concatStr(string memory a, string memory b) public pure returns (string memory){
        return string.concat(a,b);
    }
}