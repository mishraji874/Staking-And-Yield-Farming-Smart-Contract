// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract StakingYieldFarm {
    
    address public owner;
    uint256 public totalStaked;
    mapping(address => uint256) public stakedBalances;
    mapping(address => uint256) public rewards;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Stake amount must be greater than zerro");
        require(msg.sender != address(0), "invalid address");

        // Transfer tokens to contract
        // Assume there is a token contract and it has an 'approve' function
        // tokenContract.approve(address(this), amount);
        // tokenContract.transferFrom(msg.sender, address(this), amount);

        stakedBalances[msg.sender] += amount;
        totalStaked += amount;
    }

    function unstake(uint256 amount) external {
        require(amount > 0, "Unstake amount must be greater than zero");
        require(stakedBalances[msg.sender] >= amount, "Insufficient staked balances");

        stakedBalances[msg.sender] -= amount;
        totalStaked -= amount;
    }

    function claimRewards() external {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No reward tto claim");

        rewards[msg.sender] = 0;
    }

    function distributeRewards(address[] memory recipients, uint256[] memory amounts) external {
        require(recipients.length == amounts.length, "Invalid input length");

        for(uint256 i = 0; i < recipients.length; i++) {
            rewards[recipients[i]] += amounts[i];
        }
    }

    function getStakedBalance(address account) external view returns (uint256) {
        return stakedBalances[account];
    }

    function getTotalStaked() external view returns (uint256) {
        return totalStaked;
    }

    function getRewardBalance(address account) external view returns (uint256) {
        return rewards[account];
    }
}