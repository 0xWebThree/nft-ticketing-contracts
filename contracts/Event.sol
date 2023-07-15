// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ERC721/ERC721BaseURI.sol";
import "./utils/EventOwnable.sol";

contract Event is ERC721BaseURI, EventOwnable {
    uint256 public ticketSupply;
    bool public transferable;

    uint256 immutable public maxTicketSupply;
    uint256 immutable public eventStart;
    uint256 immutable public ticketPrice;

    constructor(
        string memory name,
        string memory symbol,
        address ticketPlace, 
        address owner,
        uint256 _maxTicketSupply,
        uint256 _eventStart, 
        uint256 _ticketPrice,
        bool _transferable,
        string memory _ticketBaseURI
    )
        ERC721(name, symbol)
        EventOwnable(owner, ticketPlace) 
    {
        maxTicketSupply = _maxTicketSupply;
        eventStart = _eventStart;
        ticketPrice = _ticketPrice;
        transferable = _transferable;
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

    function setTransferability(bool _transferable) external onlyOwner {
        require(
            transferable != _transferable,
            "Required transferability is already set"
        );
        transferable = _transferable;
    }

    function _transfer(address from, address to, uint256 tokenId) internal override {
       require(transferable || _checkOwner(), "Tickets aren't transferable");
       super._transfer(from, to, tokenId);
    }


}
