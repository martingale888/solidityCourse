// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleContract {
    
    function helloWorld() public pure returns (uint256) {
        return 100;
    }

    function haloDunia() public pure returns (bool) {
        return true;
    }

    function getANumber() public pure returns (uint256) {
        uint256 x = 1;
        return x;
    }

    function getABoolean() public pure returns (bool) {
        bool y = true;
        return y;
    }

    function getAnAddress() public pure returns (address) {
        // Vitalik Buterin's address
        address v = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;
        return v;
    }

    function getAnotherAddress() public pure returns (address) {
        // USDC stablecoin address
        address usdcStablecoin = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        return usdcStablecoin;
    }

    function getBiggestNumber() public pure returns (uint256) {
        return 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    }

    function getBiggestNumberPlus1() public pure returns (uint256) {
        //this will make compiler error.
        //return 115792089237316195423570985008687907853269984665640564039457584007913129639936;
        return 115792089237316195423570985008687907853269984665640564039457584007913129639934;
    }

        function getUint128Plus1() public pure returns (uint128) {
        //this will make compiler error.
        //return 340282366920938463463374607431768211456;
        return 340282366920938463463374607431768211455;
    }

    function testFloat() public pure returns(uint256) {
        uint256 interest = 200 * 0.01;
        return interest;
    }

    function testSub(uint256 x, uint256 y) public pure returns (uint256) {
        uint256 diff = x - y;
        return diff;
    }

    function testSubUnderflow(uint256 x, uint256 y) public pure returns (uint256) {
        uint256 diff = x - y;
        unchecked{
            uint256 diff = x - y;
        }
        return diff;
    }

    function testDiv(uint256 x, uint256 y) public pure returns (uint256) {
        uint256 div = x / y;
        return div;
    }

    function testExponent(uint256 x, uint256 y) public pure returns (uint256) {
        uint256 result = x ** y;
        return result;
    }

    function isAMultipleOfTen(uint256 x) public pure returns (bool) {
        bool isMul = x % 10 == 0;
        if (isMul) {
            return true;
        }
        else{
            return false;
        }
    }

    function forLoop() public pure returns (uint256) {
        uint256 sum;
        for (uint256 i = 0; i < 101; i++ ){
            sum += i;
        }
        return sum;
     }

     function getPrimeFactor(uint256 x) public pure returns (uint256){
        for (uint256 i = 2; i <= x; i++){
            if (x %i == 0){
                return i;
            }
        }
     }

     function isPrime(uint256 N) public pure returns (bool) {
        for (uint256 i = 2; i <= N / 2; i++){
            if ( N % i == 0){
                return false;
            }
        }
        return true;
     }

     function getFibonacci(uint256 x) public pure returns(uint256) {
        uint256 temp;
        uint256 n1 = 0;
        uint256 n2 = 1;
        if (x == 0){
            return n1; 
        }
        else if (x == 1)
        {
            return n2;
        }
        else {
            for (uint256 i =2; i <= x; i++){
                temp = n1 + n2;
                n1 = n2;
                n2 = temp;
            }
            return temp;
        }
     }

}