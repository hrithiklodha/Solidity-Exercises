// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Mean {
    /**
     * The goal of this exercise is to return the mean of the numbers in "arr"
     */
    function mean(uint256[] calldata arr) public view returns (uint256) {
        // your code here
        uint s;
        for (uint i = 0; i < arr.length; i++) {
            s+=arr[i];
        }
        return s/arr.length;
    }
}
