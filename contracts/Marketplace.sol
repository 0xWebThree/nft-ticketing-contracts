// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Factory.sol";
import "./Organizations.sol";

contract Marketplace is Factory, Organizations {
    mapping(address => uint256) public numberOfEvents;

    function createEvent(
        string memory name,
        string memory symbol,
        uint256 maxTicketSupply, 
        uint256 eventStart, 
        uint256 ticketPrice,
        bool transferable,
        string memory ticketBaseURI
    ) external onlyVerified
    {
        require(maxTicketSupply != 0);
        require(eventStart > block.timestamp);
        require(ticketPrice != 0);

        address newEvent = _createEventContract(
            name,
            symbol,
            maxTicketSupply,
            eventStart, 
            ticketPrice, 
            transferable,
            ticketBaseURI
        );
        organization[msg.sender].events[numberOfEvents[msg.sender]] = newEvent;
        ++ numberOfEvents[msg.sender];
    }
}