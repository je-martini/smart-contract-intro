// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract View{
    string name = 'jesus_coin';

    function get_name() public view returns(string memory){
        return name;
    }
}