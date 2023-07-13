// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ERC721BaseURI.sol";
import "./utils/EventOwnable.sol";

contract Event is ERC721BaseURI, EventOwnable {
    uint256 public ticketSupply;
    uint256 immutable public maxTicketSupply;

    uint256 immutable eventStart;
    uint256 immutable public ticketPrice;

    constructor(
        address ticketPlace, 
        address owner,
        uint256 _maxTicketSupply, 
        uint256 _eventStart, 
        uint256 _ticketPrice,
        string memory _ticketBaseURI)
        ERC721("Ticket", "T")
        EventOwnable(owner, ticketPlace) 
    {
        maxTicketSupply = _maxTicketSupply;
        eventStart = _eventStart;
        ticketPrice = _ticketPrice;
        _setBaseURI(_ticketBaseURI);
    }

    function buyTicket(uint256 ticketId) external payable {
        require(msg.value == ticketPrice);

        _ticketMint(_msgSender(), ticketId);
    }

    function _ticketMint(address owner, uint256 ticketId) private {
        require(ticketSupply + 1 <= maxTicketSupply);
        require(eventStart > block.timestamp);

        ++ ticketSupply;
        _safeMint(owner, ticketId);
    }
}
