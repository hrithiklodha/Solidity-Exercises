// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

 
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

contract CodeSize {
    //SPDX-License-Identifier: None
//Author:hrithik
    address public depositor;
    address public otherparty;
    uint public constant amount = 1 ether;
    uint public deadline;
    AggregatorV3Interface internal priceFeed;

    event DepositEth(address, uint256);
    event PulledOut(address, uint256);
    event Settled(address);

    constructor() {
        priceFeed = AggregatorV3Interface(
            0xA39434A63A52E749F02807ae27335515BA4b07F7 //goerli chainlink price fee btc/usd
        );
    }

    modifier onlydepositor() {
        require(msg.sender == depositor, "only depositor can call this function");
        _;
    }

    function getLatestPrice() public view returns (int) {
        (, int price, , , ) = priceFeed.latestRoundData();
        return price;
    }

    function depositEth() external payable {
        require(depositor == address(0), "can be called once only");
        require(amount == msg.value, "amount mismatch");
        depositor = msg.sender;
        emit DepositEth(depositor, amount);
    }

    function otherPartyDepositEth() external payable {
        require(otherparty == address(0), "can be called once only");
        require(depositor != msg.sender, "should be another party");
        require(amount == msg.value, "amount mismatch");
        otherparty = msg.sender;
        deadline = block.timestamp + 7 days;
        emit DepositEth(otherparty, amount);
    }

    function pullOut() onlydepositor external {
        require(otherparty == address(0)); // pull out funds if other party has not taken the other side
        (bool success, ) = depositor.call{value: 1 ether}("");
        require(success, "Transfer failed");
    }

    function settle() external {
        require((block.timestamp > deadline) && (otherparty != address(0)));
        int price = getLatestPrice();
        if (price >= 6e4) {
            (bool success, ) = otherparty.call{value: address(this).balance}(
                ""
            );
            require(success, "Transfer failed.");
        } else {
            (bool success, ) = depositor.call{value: address(this).balance}("");
            require(success, "Transfer failed");
        }
    }

    function emergencyWithdraw() external {
        require(
            block.timestamp > (deadline + 10 days) &&
                (otherparty == msg.sender) &&
                deadline > 0
        );
        if (depositor == msg.sender) {
            (bool success, ) = depositor.call{value: 1 ether}("");
            require(success, "Transfer failed.");
        }
        if (otherparty == msg.sender) {
            (bool success, ) = otherparty.call{value: 1 ether}("");
            require(success, "Transfer failed.");
        }
    }

    // uint256[] public arr;
    // /*
    
    //  * The challenge is to create a contract whose runtime code (bytecode) size is greater than 1kb but less than 4kb
    //  */
    //     function add(uint256 a, uint256 b) public returns (uint256) {
    //         for (uint index = 0; index < 150; index++) {
    //                     arr.push(index);
    //         }
    //     // return a + b;
    // }

//         function sub(uint256 a, uint256 b) public pure returns (uint256) {
//         return a - b;
//     }

// function div(uint256 a, uint256 b) public pure returns (uint256) {
//         return a / b;
//     }
//     function mul(uint256 a, uint256 b) public pure returns (uint256) {
//         return a * b;
//     }

}
