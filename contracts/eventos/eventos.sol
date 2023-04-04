// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Evento{
    string public token_name = "jesus_coin";

    event change_name0( address editor, string new_name0 );

    function change_name1(string memory new_name1) public {
        token_name = new_name1;
        emit change_name0(msg.sender, new_name1);
    }
}
