// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Factory.sol";

contract TicketPlace is Factory {
    address[] public allEvents;

    function createEvent(
        string memory name,
        string memory symbol,
        uint256 maxTicketSupply, 
        uint256 eventStart, 
        uint256 ticketPrice,
        bool transferable
    ) 
        external
    {
        require(maxTicketSupply != 0, "Max ticket supply cannot be zero");
        require(eventStart > block.timestamp, "Start date cannot be less than current time");
        require(ticketPrice != 0, "Ticket price cannot be zero");

        address newEvent = _createEventContract(
            name,
            symbol,
            msg.sender,
            maxTicketSupply,
            eventStart, 
            ticketPrice, 
            transferable
        );

        allEvents.push(newEvent);
    }

    function getAllEvents() external view returns(address[] memory) {
        return allEvents;
    }

    function getEventAddress(uint256 eventId) 
        public 
        view 
        returns (address) 
    {
       return allEvents[eventId];
    }
}