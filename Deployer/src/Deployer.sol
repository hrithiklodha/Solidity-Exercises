// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Deployer {
    string public greeting;

constructor(string memory _x) public{
    greeting = _x;
}
    /* This exercise assumes you know how constructors works.
    The contract must have a constructor with a string argument
    that sets the greeting variable, if not it reverts. */
}
