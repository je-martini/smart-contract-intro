// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract crofunding{

    enum is_open { open, closed }

    struct contribution{
        address contributor;
        uint value;
    }

    struct project {
        string  id;
        string  name;
        string  description;
        address payable author;
        string  string_state;
        is_open  state;
        uint  funds;
        uint  funds_reising_goal;
    }

    project[] public new_projects;
    mapping( string => contribution[]) public contributions;

    event amount_funds (uint how_much_was_found, uint current_funds, uint how_much_missing, address funder, string project_id);

    event project_state ( string notification_state, string project_id);
    
    event new_project_created( string id, string name, string description, uint funds_reising_goal);

    modifier only_author( uint project_index){
        require(
            msg.sender == new_projects[project_index].author ,
            "Sorry but only the author can change the name of the project"
        );
        _;
    }

    modifier author_cant_fund( uint project_index){
        require(
            new_projects[project_index].author != msg.sender ,
            "Sorry but you cant fund your own project"

        );
        _;
    }

    function create_project(string calldata id, string calldata name, string calldata description, uint funds_reising_goal, string calldata string_state) public {
        require(funds_reising_goal > 0, "Fundraising goal must be greater than 0");
        project memory new_project = project(id, name, description, payable(msg.sender), string_state, is_open.open, 0, funds_reising_goal);
        new_projects.push(new_project);
        emit new_project_created(id, name, description, funds_reising_goal);
    }
   
    function fund_project( uint project_index) public payable author_cant_fund(project_index) {
        project memory proyect_to_fund = new_projects[project_index];
        require(proyect_to_fund.state == is_open.open, "thanks you for trusting us but we closed the proyect");
        require(msg.value > 0, "You can't transfer 0");
        proyect_to_fund.author.transfer(msg.value);
        proyect_to_fund.funds += msg.value;
        new_projects[project_index] = proyect_to_fund;

        contributions[proyect_to_fund.id].push(contribution(msg.sender, msg.value));

        emit amount_funds(msg.value, proyect_to_fund.funds, proyect_to_fund.funds_reising_goal - proyect_to_fund.funds, msg.sender, proyect_to_fund.id);
    }

    function change_project_state(is_open new_state, uint project_index) public only_author(project_index) {
        project memory project_to_change_state = new_projects[project_index];
        require(new_state == is_open.open || new_state == is_open.closed, "This state is not defined");
        require(new_state != project_to_change_state.state, "The state that you're trying it's already on");
        
        project_to_change_state.state = new_state;
        
        if(new_state == is_open.open){
            project_to_change_state.string_state = "Open";
        }else if(new_state == is_open.closed){
            project_to_change_state.string_state = "Closed";
        }

        new_projects[project_index] = project_to_change_state;

        emit project_state(project_to_change_state.string_state, project_to_change_state.id);
    }

}