// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract IDentity {
    uint public id_number;
    bool public is_working;
    string public name;
    address public wallet;

    constructor( uint _id_number, bool _is_working, string memory _name) {
        id_number = _id_number;
        is_working = _is_working;
        name = _name;
        wallet = msg.sender;
    }
    }