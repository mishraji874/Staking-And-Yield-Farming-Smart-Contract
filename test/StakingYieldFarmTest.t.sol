// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {StakingYieldFarm} from "../src/StakingYieldFarm.sol";
import {DeployStakingYieldFarm} from "../script/DeployStakingYieldFarm.s.sol";

contract TestStakingYieldFarm is Test {
    StakingYieldFarm public stakingYieldFarm;
    address public owner;
    address public user1;
    address public user2;

    function setUp() public {
        stakingYieldFarm = new StakingYieldFarm();
        owner = stakingYieldFarm.owner();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    function testStake() public {
        vm.prank(user1);
        stakingYieldFarm.stake(100);
        assertEq(stakingYieldFarm.stakedBalances(user1), 100);
        assertEq(stakingYieldFarm.totalStaked(), 100);
    }

    function testUnstake() public {
        vm.prank(user1);
        stakingYieldFarm.stake(100);
        vm.prank(user1);
        stakingYieldFarm.unstake(50);
        assertEq(stakingYieldFarm.stakedBalances(user1), 50);
        assertEq(stakingYieldFarm.totalStaked(), 50);
    }

    function testClaimRewards() public {
        address[] memory recipients = new address[](2);
        recipients[0] = user1;
        recipients[1] = user2;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 100;
        amounts[1] = 200;

        vm.prank(owner);
        stakingYieldFarm.distributeRewards(recipients, amounts);

        vm.prank(user1);
        stakingYieldFarm.claimRewards();
        assertEq(stakingYieldFarm.getRewardBalance(user1), 0);
    }

    function testDistributeRewards() public {
    address[] memory recipients = new address[](2);
    recipients[0] = user1;
    recipients[1] = user2;

    uint256[] memory amounts = new uint256[](2);
    amounts[0] = 100;
    amounts[1] = 200;

    vm.prank(owner);
    stakingYieldFarm.distributeRewards(recipients, amounts);

    assertEq(stakingYieldFarm.getRewardBalance(user1), 100);
    assertEq(stakingYieldFarm.getRewardBalance(user2), 200);
}

    function testGetters() public {
        vm.prank(user1);
        stakingYieldFarm.stake(100);
        assertEq(stakingYieldFarm.getStakedBalance(user1), 100);
        assertEq(stakingYieldFarm.getTotalStaked(), 100);
    }
}