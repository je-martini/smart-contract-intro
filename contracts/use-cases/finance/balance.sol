// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract token_basic{
    string public constant name="JMMM-coin";
    string public constant symbol="JMMM";
    uint8 public constant decimals=18;

    uint256 _total_supply;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    event event_transfer(address indexed _from, address indexed _to, uint256 _value);
    event approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor(uint256 total){
        _total_supply = total;
        balances[msg.sender] = total;
    }

    function total_supply() public view returns (uint256) {
        return _total_supply;
    }

    function balance_of(address _owner) public view returns (uint) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_value <= balances[msg.sender], "there are not enough funds to do the transaction");
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit event_transfer(msg.sender, _to, _value);
        success = true; 
    }

    function approve(address _spender, uint256 _value) public returns ( bool success){
        allowed[msg.sender][_spender] = _value;
        emit approval(msg.sender, _spender, _value);
        success = true;
    }

    function allowance( address _owner, address _spender) public view returns (uint256 remining){
        remining = allowed[_owner][_spender];
    }

    function transfer_from(address _from, address _to, uint256 _value) public returns( bool success) {
        require(_value <= balances[_from], "there are not enough funds to do the transaction");
        require(_value <= allowed[_from][msg.sender], "sender not allowed" );

        balances[_from] = balances[_from] - _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit event_transfer(_from, _to, _value);
        success = true;
    }


}