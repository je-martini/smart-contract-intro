// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Modifier{

    address private owner;
    string public project_name = "jesus project";

    constructor(){
        owner = msg.sender;
    }

    modifier only_owner(){
        require(
            msg.sender == owner,
            "Only manolo can change the project name"
        );
        _;
    }

    function change_project_name(string memory _project_name) public only_owner{
        project_name = _project_name;
    }
}