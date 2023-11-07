// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
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
