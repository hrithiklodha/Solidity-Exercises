// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Distribute {
    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        // your code here
        uint bal = address(this).balance;
        uint l = addresses.length;
        uint amt = bal/l;
        for (uint index = 0; index < addresses.length; index++) {
        (bool suc, )=addresses[index].call{value:amt}("");
        require(suc, "fail");
        }
    }
}
