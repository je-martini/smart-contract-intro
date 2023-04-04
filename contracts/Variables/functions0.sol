// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Number{
    function get_number() public returns (int number) {
        number = 1948;
    }

    function change_number() public returns (int number) {
        number = get_number() * -1;
    }
}

