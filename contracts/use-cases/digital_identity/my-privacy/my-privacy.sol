// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract identity {

    struct basic_info{
        string name;
        string email;
    }

    struct personal_info{
        uint256 salary;
        string _address;
    }

    enum user_type{
        basic,
        personal
    }

    error user_un_authorized(address user, user_type user_type0);

    basic_info private basic_info0;
    personal_info  private personal_info0;
    address private owner;

    mapping (address => bool) private basic_users;
    mapping (address => bool) private personal_users;

    constructor(string memory name, string memory email, uint256 salary, string memory _address){
        basic_info0 = basic_info(name, email);
        personal_info0 = personal_info(salary, _address) ;
        owner = msg.sender;
    }

    modifier authorize_user(user_type user_type0) {
        if(msg.sender == owner || personal_users[msg.sender]){
            _;
        }else if(user_type0 == user_type.basic && basic_users[msg.sender]){
            _;
        } else {
            revert  user_un_authorized(msg.sender, user_type0);
        }
   }

    modifier only_owner() {
        require(msg.sender == owner, "Only owner can authorize users");
        _;
    }

    function get_basic_info() public view authorize_user(  user_type.basic) returns ( basic_info memory){
        return basic_info0;
    }

    function get_personal_infor() public view authorize_user(  user_type.personal) returns (personal_info memory){
        return personal_info0;
    }

    function register_user(user_type user_type0, address user) public only_owner{
        if(user_type0 == user_type.basic){
            basic_users[user] = true;
        } else if(user_type0 == user_type.personal){
            personal_users[user] = true;
        }
    }
}