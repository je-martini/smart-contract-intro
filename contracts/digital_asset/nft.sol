//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract my_nft is ERC721URIStorage {
    uint private _tokoen_ids;
    address owner;

    modifier only_owner(){
        require(msg.sender == owner, "Only Owner can authorize users");
        _;
    }

    constructor() ERC721("my_nft", "NFT"){
        owner = msg.sender;
    }

    function mint_nft(address recipient, string memory token_uri)
        public only_owner
        returns(uint256)
    {
        _tokoen_ids = _tokoen_ids + 1;
        _mint(recipient, _tokoen_ids);
        _setTokenURI(_tokoen_ids, token_uri);

        return _tokoen_ids;
    }
}