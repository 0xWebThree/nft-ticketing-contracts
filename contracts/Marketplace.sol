// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Factory.sol";

contract Marketplace is Factory {
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
        require(maxTicketSupply != 0);
        require(eventStart > block.timestamp);
        require(ticketPrice != 0);

        address newEvent = _createEventContract(
            name,
            symbol,
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