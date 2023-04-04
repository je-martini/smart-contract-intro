// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Pure{
    int number = 100;
    function sum(int a, int b) public pure returns(int result){
        result = a + b;
    }
}