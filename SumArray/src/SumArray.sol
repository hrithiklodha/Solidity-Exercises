// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract SumArray {
    function sumArray(uint256[] calldata arr) public pure returns (uint256) {
        // your code here
        // arr is a list of unsigned integers
        // return the sum of them. If the array
        // is empty, return 0
        if (arr.length==0) {
            return 0;
        }
        uint s;
        for (uint i = 0; i < arr.length; i++) {
            s+=arr[i];
        }
        return s;
    }
}
