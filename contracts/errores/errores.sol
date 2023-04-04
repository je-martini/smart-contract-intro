// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract error {
    string public state = "on_sale";

    error state_no_defined(uint unit);

    function change_state(uint new_state) public {
        require(new_state == 0 || new_state == 1, "this state is not defined");
        if(new_state == 0){
            state = "on_sale";
        }else if(new_state == 1){
            state = "not_for_sale";
        }
        //  else {
        //     revert state_no_defined(new_state);
        // }
    }
}