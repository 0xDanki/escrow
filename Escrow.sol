// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
    address public depositor;
    address public arbiter;
    address public beneficiary;
    bool public isApproved;

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    event Approved(uint);
    function approve() external {
        require(msg.sender == arbiter);
        uint balance = address(this).balance;
        (bool sent, ) = beneficiary.call{ value: balance }("");
        require(sent, "Failed to send ether");
        isApproved = true;
        emit Approved(balance);
    }
}
