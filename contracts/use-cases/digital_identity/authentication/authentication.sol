// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract authenticate {
    
    mapping( address => bool) public users;

    function authenticator() public {
        users[msg.sender] = true;
    }
}