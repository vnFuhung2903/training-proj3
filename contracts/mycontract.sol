// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS

// ADD YOUR CONTRACT CODE BELOW

    mapping (address => uint) private lastActive;
    mapping (address => uint) private totalOwed;
    address[] private allUsers;
    mapping (address => bool) private checkUser;
    mapping (address => mapping (address => uint)) private owe;
    mapping (address => address[]) private neighbors;

    function add_IOU(address _to, uint _amount) public {
        address _sender = msg.sender;
        lastActive[_sender] = block.timestamp;
        totalOwed[_sender] += _amount;
        if(!checkUser[_sender]) {
            checkUser[_sender] = true;
            allUsers.push(_sender);
            neighbors[_sender].push(_to);
        }

        if(!checkUser[_to]) {
            checkUser[_to] = true;
            allUsers.push(_to);
        }

        owe[_sender][_to] = _amount;
        owe[_to][_sender] = 0;
    }

    function getAllUsers() public view returns(address[] memory) {
        return allUsers;
    }

    function getLastActive(address user) public view returns(uint) {
        return lastActive[user];
    }

    function getTotalOwed(address user) public view returns(uint) {
        return totalOwed[user];
    }

    function lookup(address debtor, address creditor) public view returns(uint) {
        return owe[debtor][creditor];
    }

    function getAddress() public view returns(address) {
        return msg.sender;
    }

    function getCreditor(address node) public view returns(address[] memory) {
        return neighbors[node];
    }
}
