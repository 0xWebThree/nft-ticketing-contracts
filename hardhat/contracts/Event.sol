// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./utils/EventOwnable.sol";

contract Event is ERC721URIStorage, EventOwnable {
    uint256 public totalSupply;

    constructor(address _ticketPlace, address owner)
        ERC721("Ticket", "T")
        EventOwnable(owner) 
    {
        ticketPlace = _ticketPlace;
    }

    function safeMint(address owner, string memory uri) 
        public 
        onlyOwnerOrTicketPlace 
    {
        ++ totalSupply;
        _safeMint(owner, totalSupply);
        _setTokenURI(totalSupply, uri);
    }
}
