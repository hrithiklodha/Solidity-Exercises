// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */
    uint public bid;
    address public winner;
    uint public deadline = block.timestamp + 3600;

    function bet() public payable {
        require(msg.value > 0, "0");
        // require(msg.value > bid,"less");
        require(block.timestamp < deadline);
        if (msg.value > bid) {
            bid = msg.value;
            winner = msg.sender;
            deadline = block.timestamp + 3600;
        }
    }

    function gbalance() public view returns (uint) {
        return address(this).balance;
    }

    function claimPrize() public {
        require(msg.sender == winner, "nowinner");
        require(block.timestamp > deadline, "timeleft");
        (bool suc, ) = winner.call{value: address(this).balance}("");
        require(suc, "fail");
    }
}
