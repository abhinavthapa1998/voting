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

    function giveRightToVote(address voter) public {
        require(
            msg.sender == chairperson,
            "Only the Chairperson can give access to vote."
        );
        require(!voters[voter].voted, "The voter has already voted");
        require(voters[voter].weight == 0);
        voters[voter].weight == 1;
    }

    function vote(uint256 proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint256 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                _winningProposal = i;
            }
        }
    }
}
