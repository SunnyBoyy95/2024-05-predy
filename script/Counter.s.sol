// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
    }
forge script CounterScript --fork-url <`https://eth-mainnet.alchemyapi.io/v2/YOUR-API-KEY`>

}
