// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Tupledore {
    /* This exercise assumes you know about tuples/struct in solidity.
        1. Create a struct named `UserInfo` with types address 
           and uint256.
        2. Create a variable of type UserInfo, named `userInfo`.
        3. Create a function called `setTuple` that takes in 
           a address and uint256 and sets the all values 
           the `userInfo` variable you created above.
        4. Create a function called `returnTuple`, 
           that returns `userInfo` (as a tuple)
    */
   struct UserInfo{
      address addr;
      uint256 value;
   }

   UserInfo public userInfo;

   function setTuple(address _add, uint256 _value) public {
      userInfo.addr = _add;
      userInfo.value = _value;
   }

   function returnTuple() public view returns(UserInfo memory){
         return userInfo;
   }
}
