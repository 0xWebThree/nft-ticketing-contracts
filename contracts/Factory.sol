// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Event.sol";

abstract contract Factory {
    event EventCreated(address _event);

    function _createEventContract(
        string memory name,
        string memory symbol,
        uint256 maxTicketSupply, 
        uint256 eventStart, 
        uint256 ticketPrice,
        bool _transferable,
        string memory ticketBaseURI
    ) 
        internal returns(address newEvent) 
    {
        Event newEventContract = new Event(
            name,
            symbol,
            address(this),
            msg.sender,
            maxTicketSupply, 
            eventStart, 
            ticketPrice,
            _transferable,
            ticketBaseURI
        );
        newEvent = address(newEventContract);
        emit EventCreated(newEvent); 
    }

}