// SPDX-License-Identifier: MIT
pragma solidity <=0.9;

contract Ballot {
    struct Voter {
        uint256 vote;
        bool voted;
        uint256 weight;
    }

    struct Proposal {
        bytes32 name;
        uint256 vouteCount;
    }

    Proposal[] public proposals;

    mapping(address => Voter) public voters;
}
