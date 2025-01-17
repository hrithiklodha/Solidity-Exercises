// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract FizzBuzz {
    function fizzBuzz(uint256 n) public pure returns (string memory) {
        // if n is divisible by 3, return "fizz"
        // if n is divisible by 5, return "buzz"
        // if n is divisible be 3 and 5, return "fizz buzz"
        // otherwise, return an empty string
         bytes memory result;
        
        if (n % 3 == 0) {
            result = abi.encodePacked("fizz");
        }
        if (n % 5 == 0) {
            if (n % 3 == 0) {
                result = abi.encodePacked(result, " buzz");
            } else {
                result = abi.encodePacked("buzz");
            }
        }
        
        return string(result);
    }
}
