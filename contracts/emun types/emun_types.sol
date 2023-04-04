// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Enum {
    enum state { active, inactive }

    state public state_act = state.inactive;

    function change_state(state new_state) public {
        state_act = new_state;
    }
}