// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract struct_types {
    struct hero{
        string name;
        uint age;
        string power;
        string team;
    }

    hero batman = hero("Batman", 28, "Mucho dinero", "liga de la Justicia");

    // batman.name;
    // batman.age;
    // batman.power;
    // batman.team;
}