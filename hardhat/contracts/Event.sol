// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./utils/EventOwnable.sol";

contract Event is ERC721URIStorage, EventOwnable {
    uint256 public ticketSupply;
    uint256 immutable public maxTicketSupply;

    uint256 immutable eventStart;
    uint256 immutable public ticketPrice;

    constructor(
        address ticketPlace, 
        address owner,
        uint256 _maxTicketSupply, 
        uint256 _eventStart, 
        uint256 _ticketPrice)
        ERC721("Ticket", "T")
        EventOwnable(owner, ticketPlace) 
    {
        maxTicketSupply = _maxTicketSupply;
        eventStart = _eventStart;
        ticketPrice = _ticketPrice;
    }

    /** 
     * @custom:proposal обдумать с uri (защита?)
    */
    function buyTicket(uint256 ticketId, string memory uri) external payable {
        require(msg.value == ticketPrice);
        _ticketMint(_msgSender(), ticketId, uri);
    }

    function _ticketMint(address owner, uint256 ticketId, string memory uri) private {
        require(ticketSupply + 1 <= maxTicketSupply);
        require(eventStart > block.timestamp);

        ++ ticketSupply;
        _safeMint(owner, ticketId);
        _setTokenURI(ticketId, uri);
    }

    function getTicketPrice() public view returns(uint256) {
        return ticketPrice;
    }
}
