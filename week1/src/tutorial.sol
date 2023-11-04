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

     function useArrayForUint256(uint256[] calldata input) public pure returns(uint256[] memory){
        return input;
     }

    function returnFirstElement(uint256[] calldata input) public pure returns(uint256){
        return input[0];
     }

    function getArrayLength(uint256[] calldata input) public pure returns(uint256){
        return input.length;
     }

    function productOfArray(uint256[] calldata input) public pure returns(uint256){
        uint256 product = 1;
        for (uint256 i= 0; i< input.length; i++){
            product *= input[i];
        }
        return product;
     }

    function productOfArrayFixedSize(uint256[4] calldata input) public pure returns(uint256){
        uint256 product = 1;
        for (uint256 i= 0; i< input.length; i++){
            product *= input[i];
        }
        return product;
     }

     function concatExample(string calldata user) public pure returns( string memory){
        return string.concat("your username is  ", user);
     }

     function partOfArray(string calldata str) public pure returns(string memory){
        //return str[0];      //this will not compile
        return str;
        //return str.length;     //this will not compile
     }

     function fizzBuss(uint256 n) public pure returns (string memory){
        // if n is divisible by 3, return "fizz"
        // if n is divisible by 5, return "buzz"
        // if n is divisible be 3 and 5, return "fizz buzz"
        // otherwise, return an empty string
        if ( n % 3 == 0 ){
            if ( n % 5 == 0){
                return "fizz buzz";
            }
            else {
                return "fizz";
            }
        }
        else if ( n % 5 == 0) {
            return "buzz";
        }
        else {
            return "";
        }
     }

     function sumArray(uint256[] calldata arr) public pure returns (uint256) {
        // your code here
        // arr is a list of unsigned integers
        // return the sum of them. If the array
        // is empty, return 0
        if (arr.length == 0){
            return 0;
        }
        else{
            uint256 sum;
            for (uint256 i = 0; i < arr.length; i++){
                sum += arr[i];
            }
            return sum;
        }
    }

    /*
        This exercise assumes you understand how to manipulate Array.
        1. Function `filterOdd` takes an array of uint256 as argument. 
        2. Filter and return an array with the odd numbers removed.
        Note: this is tricky because you cannot allocate a dynamic array in memory, 
              you need to count the even numbers then declare an array of that size.
    */
    function filterOdd(uint256[] memory _arr) public pure returns (uint256[] memory)
    {
        // your code here
        uint256 numOfEven = 0;
        for (uint256 i = 0; i < _arr.length; i++){
            if (_arr[i] % 2 == 0){
                numOfEven++;
            }
        }
        if (numOfEven >0){
            uint256[] memory evenArr = new uint256[](numOfEven);
            uint256 j;
            for (uint256 i = 0; i < _arr.length; i++){
                if (_arr[i] % 2 == 0){
                    evenArr[j] = _arr[i];
                    j ++;
                }
            }
            return evenArr;
        }
        else{
            uint256[] memory result = new uint256[](0);
            return result;
        }
    }

    /**
     * The goal of this exercise is to return true if the members of "arr" is sorted (in ascending order) or false if its not.
     */
    function isSorted(uint256[] calldata arr) public pure returns (bool) {
        // your code here
        if (arr.length < 2) {
            return false;
        }
        else{
            for (uint256 i = 1; i < arr.length; i++) {
                if (arr[i] < arr[i-1]){
                    return false;
                }
            }
        }
        return true;
    }

     /**
     * The goal of this exercise is to return the mean of the numbers in "arr"
     */
    function mean(uint256[] calldata arr) public pure returns (uint256) {
        // your code here
        uint256 N;
        uint256 sum;
        for (uint256 i = 0; i < arr.length; i++){
            N ++;
            sum += arr[i];
        }
        return sum / N;
    }

    function containsA3(uint256[][] calldata nestedArray) public pure returns (bool) {
        for ( uint256 i = 0; i < nestedArray.length; i ++){
            for (uint256 j = 0; j < nestedArray[i].length; j++){
                if (nestedArray[i][j] == 3){
                    return true;
                }
            }
        }
        return false;
    }

    // ACCEPTED: [[1,2],[3,4],[5,6]]
    // REJECTED: [[1,2,3],[4,5,6]]
    function fixedSizeArray(uint256[2][3] calldata nestedArray) public pure returns (uint256) {
        return nestedArray[2][1]; // just for the sake of compilation
    }

    uint256[][] public arr;

    function setArr(uint256[][] memory newArr) public {
        arr = newArr;
    }

    /**
     * This function is expected to get the sum of all members of each nested array and finally return the sum of all the nested sums
     * Example: [[1,2], [3,4]] this should return 1 + 2 + 3 + 4 = 10
     */
    function getNestedSum() public view returns (uint256) {
        // your code here
        uint256 sum;
        for ( uint256 i = 0; i < arr.length; i ++){
            for (uint256 j = 0; j < arr[i].length; j++){
                sum += arr[i][j];
            }
        }
        return sum;
    }


    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's and 0's elements and it is also a 3x3 nested array.
    */

    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        // your code here
        //check 1's
        if (board[0][0] == 1){
            if ( (board[1][0] == 1 && board[2][0] == 1) || (board[1][1] == 1 && board[2][2] == 1) ){
                return true;
            }
        }else if (board[0][1] == 1){
            if (board[1][1] == 1 && board[2][1] == 1) {
                return true;
            }
        }else if (board[0][2] == 1){
            if (board[1][2] == 1 && board[2][2] == 1) {
                return true;
            }
        }

        //check 0's
        if (board[0][0] == 0){
            if ( (board[1][0] == 0 && board[2][0] == 0) || (board[1][1] == 1 && board[2][2] == 0) ){
                return true;
            }
        }else if (board[0][1] == 0){
            if (board[1][1] == 0 && board[2][1] == 0) {
                return true;
            }
        }else if (board[0][2] == 0){
            if (board[1][2] == 0 && board[2][2] == 0) {
                return true;
            }
        }
        return false;
    }

}