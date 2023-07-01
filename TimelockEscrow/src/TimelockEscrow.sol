// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;
    mapping(address => uint256) private orderValue;
    mapping(address => uint256) private orderTime;


    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        require(msg.value>=0, "0");
        orderValue[msg.sender]+=msg.value;
        orderTime[msg.sender]=block.timestamp;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(block.timestamp>orderTime[buyer]+3 days,"lock");
        require(orderValue[buyer] > 0, "0");
        uint256 amt = orderValue[buyer];
        orderValue[buyer] = 0;
        orderTime[buyer]=0;
        (bool suc, ) = seller.call{value:amt}("");
        require(suc, "fail");
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        require(block.timestamp<=orderTime[msg.sender]+3 days,"lock");
        require(orderValue[msg.sender] > 0, "0");
        uint amt = orderValue[msg.sender];
        orderValue[msg.sender] = 0;
        orderTime[msg.sender]=0;
        (bool suc, ) = msg.sender.call{value:amt}("");
        require(suc, "fail");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return orderValue[buyer];
    }
}
