// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title Counter
 * @dev A simple counter contract with increment/decrement functionality and access control
 */
contract Counter {
    uint256 public count;
    address public owner;

    event CounterIncremented(uint256 newValue);
    event CounterDecremented(uint256 newValue);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        count = 0;
    }

    /**
     * @dev Increments the counter by 1
     * Emits CounterIncremented event
     */
    function increment() public {
        count++;
        emit CounterIncremented(count);
    }

    /**
     * @dev Decrements the counter by 1
     * Requires count to be greater than 0
     * Emits CounterDecremented event
     */
    function decrement() public {
        require(count > 0, "Cannot decrement below zero");
        count--;
        emit CounterDecremented(count);
    }

    /**
     * @dev Sets the counter to a specific value (only owner)
     * @param _count The new counter value
     */
    function setCount(uint256 _count) public onlyOwner {
        count = _count;
    }

    /**
     * @dev Resets the counter to zero (only owner)
     */
    function reset() public onlyOwner {
        count = 0;
    }

    /**
     * @dev Transfers ownership to a new address
     * @param _newOwner The address of the new owner
     */
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        address previousOwner = owner;
        owner = _newOwner;
        emit OwnershipTransferred(previousOwner, _newOwner);
    }

    /**
     * @dev Gets the current counter value
     * @return The current count
     */
    function getCount() public view returns (uint256) {
        return count;
    }
}
