// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    mapping (address => uint) balances;
    mapping (address => uint) time;
    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return balances[user];
    }

    function depositEther() external payable {
        /// add code here
        require(msg.value>0, "0");
        time[msg.sender] = block.timestamp+604800;
        balances[msg.sender] += msg.value;
    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        require(balances[msg.sender]>0, "0");
        require(block.timestamp >= time[msg.sender],"time");
        require(amount<=balances[msg.sender], "insuff");
        balances[msg.sender] -= amount;
        (bool suc, ) = msg.sender.call{value:amount}("");
        require(suc, "fail");
    }
}
