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
        uint256 voteCount;
    }

    Proposal[] public proposals;

    mapping(address => Voter) public voters;

    address public chairperson;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }
}
