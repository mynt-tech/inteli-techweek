// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    error NotArbiter();

    event Approved(uint);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        uint256 balance = address(this).balance;
        
        if (msg.sender != arbiter) {
            revert NotArbiter();
        }
        
        (bool success, ) = beneficiary.call{ value: balance }("");
        require(success);

        emit Approved(balance);
    }
}