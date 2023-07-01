// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Factory.sol";
import "./Organizations.sol";
import "./interfaces/IEvent.sol";

contract Marketplace is Factory, Organizations {
    mapping(address => uint256) public numberOfEvents;

    function createEvent(
        uint256 maxTicketSupply, 
        uint256 eventStart, 
        uint256 ticketPrice
    ) external onlyVerified
    {
        require(maxTicketSupply != 0);
        require(eventStart > block.timestamp);
        require(ticketPrice != 0);

        address newEvent = _createEventContract(maxTicketSupply, eventStart, ticketPrice);
        organization[msg.sender].events[numberOfEvents[msg.sender]] = newEvent;
        ++ numberOfEvents[msg.sender];
    }

    //function buyTicket() external payable {
    //}

    function getTicketPrice(address _event) public view returns(uint256) {
        IEvent eventContract = IEvent(_event);
        return eventContract.getTicketPrice();
    }
}