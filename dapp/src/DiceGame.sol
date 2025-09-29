// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import { IEOFeedManager } from "eo/interfaces/IEOFeedManager.sol";

contract DiceGame {
    IEOFeedManager public immutable feedManager;
    uint256 public constant FEED_ID = 0;
    uint256 public totalBets;
    uint256 public winningSide;
    uint256 public oracleValue;
    bool public resolved;

    struct Bet {
        uint256 amount;
        uint256 choice;
    }
    mapping(address => Bet) public bets;
    mapping(uint256 => uint256) public choiceAmounts;
    
    constructor(address _feedManager) {
        feedManager = IEOFeedManager(_feedManager);
    }

    function bet(uint256 choice) external payable {
        bets[msg.sender] = Bet({
            amount: msg.value,
            choice: choice
        });
        totalBets += msg.value;
    }

    function resolve() external {
        IEOFeedManager.PriceFeed memory priceFeed = feedManager.getLatestPriceFeed(FEED_ID);
        require(priceFeed.timestamp > 0, "Oracle data not available");
        oracleValue = priceFeed.value;
        winningSide = (oracleValue % 6) + 1; // Convert to 1-6
        resolved = true;
    }

    receive() external payable {}
}
