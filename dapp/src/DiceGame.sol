// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import { IEOFeedManager } from "eo/interfaces/IEOFeedManager.sol";

contract DiceGame {
    IEOFeedManager public immutable feedManager;
    uint256 public constant FEED_ID = 0;
    uint256 public totalBets;
    uint256 public winningSide;
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

    receive() external payable {}
}
