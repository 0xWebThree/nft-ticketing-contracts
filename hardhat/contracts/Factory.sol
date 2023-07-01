// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Event.sol";

abstract contract Factory {
    event EventCreated(address _event);

    function _createEventContract(
        uint256 maxTicketSupply, 
        uint256 eventStart, 
        uint256 ticketPrice
    ) internal returns(address newEvent) {
        Event newEventContract = new Event(
            address(this),
            msg.sender,
            maxTicketSupply, 
            eventStart, 
            ticketPrice
        );
        newEvent = address(newEventContract);
        emit EventCreated(newEvent); 
    }

}