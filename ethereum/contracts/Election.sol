pragma solidity ^0.4.21;

import "./Owned.sol";
import "./Voter.sol";

contract DateTime {
    function toTimestamp(uint16 year, uint8 month, uint8 day, uint8 hour) public pure returns (uint timestamp);
}

contract Election is Owned, Voter {

  address public dateTimeAddr = 0x3d781d878679afbcaa1952096a94417c7c00468c;
  DateTime dateTime = DateTime(dateTimeAddr);

  // Election variables
  uint id;
  string name;
  uint public startDate;
  uint public endDate;

  // Party struct
  struct Party {
    uint id;
    string name;
    uint voteCount;
  }

  // Candicate struct
  struct Candidate {
    uint id;
    uint partyID;
    string firstName;
    string initials;
    string lastName;
    string location;
    string gender;
    uint position;
    uint voteCount;
  }

  // Test data when the contracts gets deployed -- Only needed for testing
  constructor() public {
    addParty("PVV");
    addParty("CDA");

    addCandidate(1,"Geert", "G.", "Wilders", "Amsterdam", "M", 1);
    addCandidate(2,"Joep", "J.", "Woop", "Amsterdam", "M",1);

    setStartDate(2018,4,24,0);
    setEndDate(2018,5,30,0);
  }

  // Store voters tokens
  mapping(string => bool) private voters;
  // Keeps count of voters
  uint private votersCount;

  // This is where the parties are stored
  mapping(uint => Party) private parties;
  // Keeps count of parties
  uint public partiesCount;

  // This is where the candidates are stored
  mapping(uint => Candidate) private candidates;
  // Keeps count of candidates
  uint public candidatesCount;

  /** @title Set the name of the election. */
  /**
   * @dev Only the owner can set the name for the election.
   * @param _name The year of the election.
   */
  function setElectionName(string _name) onlyOwner public {
      name = _name;
  }

  /** @title Set a start date to the election. */
  /**
   * @dev Only the owner can set the start date for the election.
   * @param _year The year of the election.
   * @param _month The month of the election.
   * @param _day The day of the election.
   * @param _hour The hour of the election.
   */
  function setStartDate(uint16 _year, uint8 _month, uint8 _day, uint8 _hour) onlyOwner public {
      startDate = dateTime.toTimestamp(_year,_month,_day,_hour);
  }

  /** @title Set an end date to the election. */
  /**
   * @dev Only the owner can set the end date for the election.
   * @param _year The year of the election.
   * @param _month The month of the election.
   * @param _day The day of the election.
   * @param _hour The hour of the election.
   */
  function setEndDate(uint16 _year, uint8 _month, uint8 _day, uint8 _hour) onlyOwner public {
      endDate = dateTime.toTimestamp(_year,_month,_day,_hour);
  }

  /** @title Adds a party to the election. */
  /**
   * @dev Only the owner can add a party to the election.
   * @param _name The name of the party.
   */
  function addParty(string _name) onlyOwner public {
    partiesCount++;
    parties[partiesCount] = Party(partiesCount,_name,0);
  }

  /** @title Adds a candidate to the election. */
  /**
   * @dev Only the owner can add a candidate to the election.
   * @param _partyID The Party ID of the candidate.
   * @param _firstName The first name of the candidate.
   * @param _initials The initials of the candidate.
   * @param _lastName The last name of the candidate
   * @param _location The location of the candidate.
   * @param _gender The gender of the candidate.
   * @param _position The position of the candidate.
   */
  function addCandidate(uint _partyID, string _firstName, string _initials, string _lastName, string _location, string _gender, uint _position) onlyOwner public {
    candidatesCount++;
    candidates[candidatesCount] = Candidate(candidatesCount, _partyID, _firstName, _initials, _lastName, _location, _gender, _position,0);
  }

  /** @title Vote for a candidate. */
  /**
   * @dev Only the voter can call this function to vote for a candidate.
   * @param candidate_id The ID of the candicate.
   * @param _token The token of the user that votes.
   */
  function vote(uint candidate_id, string _token) onlyVoter public {
    // Require that they haven't voted before
    require(!voters[_token]);
    // Require that the vote is before endTime
    require(now >= startDate && now < endDate);
    // Require valid candidates
    require(candidate_id > 0 && candidate_id <= candidatesCount);

    // Record that voter has voted;
    voters[_token] = true;
    votersCount++;

    // Record vote that voter submitted;
    parties[getPartyIdFromCandidate(candidate_id)].voteCount++;
    candidates[candidate_id].voteCount++;
  }

  /** @title Get the partyID from the Candidate. */
  /**
   * @param candidateID The ID of the Candidate.
   * @return The partyID.
   */
  function getPartyIdFromCandidate(uint candidateID) view private returns (uint) {
    return candidates[candidateID].partyID;
  }

  /** @title Get the amount of voters */
  /**
   * @return The amount of voters.
   */
  function getVotersCount() view onlyOwner public returns (uint) {
      return votersCount;
  }

  /** @title Get details from Candidate */
  /**
   * @dev This is used for the front-end to get the candidate details saved in the contract
   * @param _candidateID The ID of the Candidate.
   * @return The candidate details.
   */
  function getCandidateWithoutCount(uint _candidateID) view public returns (uint, uint, string, string, string, uint, string) {
    require(_candidateID > 0 && _candidateID <= candidatesCount);

    Candidate storage c = candidates[_candidateID];

    return (_candidateID, c.partyID, c.firstName, c.initials, c.lastName, c.position, c.location);
  }

  /** @title Get details from Party */
  /**
   * @dev This is used for the front-end to get the parties saved in the contract
   * @param _partyID The ID of the Candidate.
   * @return The partyID and Name.
   */
  function getPartyWithoutCount(uint _partyID) view public returns (uint, string) {
    require(_partyID > 0 && _partyID <= partiesCount);
    return (_partyID, parties[_partyID].name);
  }

  /** @title Get voteCount from Party. */
  /**
   * @dev This returns the voteCount for the given partyID (Only when the election is ended).
   * @param _partyID The ID of the party.
   * @return The voteCount.
   */
  function getVoteCountFromParty(uint _partyID) view public returns (uint) {
    require(now >= endDate);
    return (parties[_partyID].voteCount);
  }

  /** @title Get voteCount from Candidate. */
  /**
   * @dev This returns the voteCount for the given candidateID (Only when the election is ended).
   * @param _candicateID The ID of the candidate.
   * @return The voteCount.
   */
  function getVoteCountFromCandidate(uint _candicateID) view public returns (uint) {
    require(now >= endDate);
    return (candidates[_candicateID].voteCount);
  }

}
