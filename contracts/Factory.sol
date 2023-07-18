// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Event.sol";
import "@openzeppelin/contracts/utils/Context.sol";

abstract contract Factory is Context {
    event EventCreated(address indexed organization, address _event);

    function _createEventContract(
        string memory name,
        string memory symbol,
        uint256 maxTicketSupply, 
        uint256 eventStart, 
        uint256 ticketPrice,
        bool transferable
    ) 
        internal returns(address newEvent) 
    {
        Event newEventContract = new Event(
            name,
            symbol,
            address(this),
            maxTicketSupply, 
            eventStart, 
            ticketPrice,
            transferable
        );
        newEvent = address(newEventContract);

        emit EventCreated(_msgSender(), newEvent); 
    }
}