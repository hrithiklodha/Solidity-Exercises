// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Typecast {
    /**
     * the goal of this exercise is to pass if msg.value is equal to the address of this contract or revert otherwise
     */

    function typeCast() external payable {
        // your code here
        // require(msg.value == uint256(uint160(address(this))), "fail");
        // require(address(this) == address(uint160(msg.value)), "fail");
        // TODO
        require(address(uint160(uint256(msg.value)))==address(this), "Value mismatch");
    }
    function addy() view public returns (address) {
        return address(this);
    }
}
