// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DiceGame} from "../src/DiceGame.sol";

contract DiceGameScript is Script {
    DiceGame public diceGame;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        diceGame = new DiceGame(address(0x5a38f4ee6e1da80b36fa94ad1d55f48a64f60572));

        vm.stopBroadcast();
    }
}
