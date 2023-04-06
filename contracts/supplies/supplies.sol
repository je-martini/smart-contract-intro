// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract supply_chain{

    enum status {
        CREATED,
        READY_FOR_PICK_UP,
        PICK_UP,
        READY_FOR_DELIVERY,
        DELIVERED
    }

    struct step {
        status status0;
        string metadata;
        uint256 price;
        address author;
    }

    event registered_step(
        uint product_id,
        status status0,
        string metadata,
        address author,
        uint price
    );



    mapping(uint256 => step[]) public  products;


    function register_product(uint256 product_id) public returns (bool success){
        require(products[product_id].length == 0, "this product already exists");
        products[product_id].push(step(status.CREATED, " ", 0, msg.sender));
        return success;
    }

    function register_step(
        uint256 product_id,
        string calldata metadata,
        uint256 price
    ) public payable returns (bool success){
        require(products[product_id].length > 0, "this product doesn't exist");
        step[] memory steps_array = products[product_id];
        uint256 current_status = uint256(
            steps_array[steps_array.length - 1 ].status0
        ) + 1;


        if(current_status > uint256(status.DELIVERED)){
            revert("the product has no more steps");
        }
        if (current_status == uint256(status.PICK_UP) || 
            current_status == uint256(status.DELIVERED)
        ) {
            uint256 _price = steps_array[current_status - 1].price;

            if(msg.value < _price){
                revert("you need yo pay the service");
            }
            address payable _to = payable (steps_array[current_status - 1].author);
            _to.transfer(_price);
        }   
        step memory step0 = step( 
            status(current_status),
            metadata,
            price,
            msg.sender
        );
        products[product_id].push(step0);
        
        
        emit registered_step(product_id, status(current_status), metadata, msg.sender, price);
        
        success = true;
    }
    
}