// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract DistributeV2 {
    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
        3. Consider scenarios where one of the recipients rejects the ether transfer, 
           have a work around for that whereby other recipients still get their transfer
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        address[] memory acceptions = addresses;
        uint bal = address(this).balance;
        uint l = addresses.length;
        uint amt = bal / l;
        uint256 rejections = 0;
        for (uint i = 0; i < addresses.length; i++) {
            (bool suc, ) = addresses[i].call{value: amt}("");
            if (!suc) {
                rejections++;
            } else {
                address last = acceptions[acceptions.length - 1];
                delete acceptions[i];
                acceptions[i] = last;
            }
        }
        if (rejections > 0) {
            for (uint256 i = 0; i < acceptions.length; i++) {
                acceptions[i].call{value: amt}("");
            }
        }
    }
}
