// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Event is ERC721URIStorage, Ownable {
    uint256 public ticketSupply;
    bool public transferable;

    uint256 immutable public maxTicketSupply;
    uint256 immutable public eventStart;
    uint256 immutable public ticketPrice;

    event TicketSold(address indexed buyer, uint256 indexed ticketId);

    constructor(
        string memory name,
        string memory symbol,
        address owner,
        uint256 _maxTicketSupply,
        uint256 _eventStart, 
        uint256 _ticketPrice,
        bool _transferable
    )
        ERC721(name, symbol)
        Ownable() 
    {
        maxTicketSupply = _maxTicketSupply;
        eventStart = _eventStart;
        ticketPrice = _ticketPrice;
        transferable = _transferable;

        _transferOwnership(owner);
    }

    function buyTicket(uint256 ticketId, string memory uri) external payable {
        require(msg.value == ticketPrice, "Sended value isn't equal to ticket price");

        _ticketMint(_msgSender(), ticketId);
        _setTokenURI(ticketId, uri);
    }

    function _ticketMint(address owner, uint256 ticketId) private {
        require(ticketSupply + 1 <= maxTicketSupply, "Minting more tokens is forbidden");
        require(eventStart > block.timestamp, "Start date cannot be less than current time");

        ++ ticketSupply;
        _safeMint(owner, ticketId);

        emit TicketSold(owner, ticketId);
    }

    function setTransferability(bool _transferable) external onlyOwner {
        require(
            transferable != _transferable,
            "Required transferability is already set"
        );
        transferable = _transferable;
    }

    function isOver() external view returns(bool) {
        return eventStart < block.timestamp;
    }

    function getTicketSupply() external view returns(uint256) {
        return ticketSupply;
    }

    function areTickertsTransferable() external view returns(bool) {
        return transferable;
    }

    function getMaxTicketSupply() external view returns(uint256) {
        return maxTicketSupply;
    }

    function getEventStart() external view returns(uint256) {
        return eventStart;
    }

    function getFixedTicketPrice() external view returns(uint256) {
        return ticketPrice;
    }

    function _transfer(address from, address to, uint256 tokenId) internal override {
       require(transferable || (owner() == _msgSender() || from == address(0)), "Tickets aren't transferable");
       super._transfer(from, to, tokenId);
    }
}
