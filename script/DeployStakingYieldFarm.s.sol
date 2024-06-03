// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {StakingYieldFarm} from "../src/StakingYieldFarm.sol";

contract DeployStakingYieldFarm is Script {

    function run() external returns (StakingYieldFarm) {
        vm.startBroadcast();
        StakingYieldFarm stakingYieldFarm = new StakingYieldFarm();
        vm.stopBroadcast();
        return stakingYieldFarm;
    }
}