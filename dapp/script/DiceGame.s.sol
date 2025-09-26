// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DiceGame} from "../src/DiceGame.sol";

contract DiceGameScript is Script {
    DiceGame public diceGame;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        diceGame = new DiceGame();

        vm.stopBroadcast();
    }
}
