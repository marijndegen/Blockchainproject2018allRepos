pragma solidity ^0.4.2;

/**
 * @title Voter
 * @dev The Voter contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */

contract Voter {
    address voter;

    event OwnershipTransferred(address indexed previousVoter, address indexed newVoter);

  /**
   * @dev The Voter constructor sets the original `voter` of the contract to the sender
   * account.
   */
    constructor() public {
        voter = 0x18ccda869b88fa5f72db2755327159b93adad6ce;
    }

  /**
   * @dev Throws if called by any account other than the voter.
   */
    modifier onlyVoter {
        require(msg.sender==voter);
        _;
    }

  /**
   * @dev Allows the current voter to transfer control of the contract to a newVoter.
   * @param newVoter The address to transfer ownership to.
   */
  function transferVoterOwnership(address newVoter) public onlyVoter {
    require(newVoter != address(0));
    emit OwnershipTransferred(voter, newVoter);
    voter = newVoter;
  }
}
