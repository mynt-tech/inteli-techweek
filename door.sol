// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Door {
    address[] public winners;
    mapping(address => bool) alreadyEntered;

    function getWinners() external view returns (address[] memory) {
        return winners;
    }
 
    function enter() external {
        require(msg.sender != tx.origin);
        require(msg.sender.code.length == 0);
        require(!alreadyEntered[tx.origin]);

        alreadyEntered[tx.origin] = true;

        winners.push(tx.origin);
    }
}