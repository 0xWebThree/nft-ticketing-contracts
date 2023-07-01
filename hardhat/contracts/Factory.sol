// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Event.sol";
import "./Organizations.sol";

contract Factory is Organizations {
    event EventCreated(address _event);

    function createEvent() public returns(Event newEventContract) {
        newEventContract = new Event(address(this), msg.sender);
        emit EventCreated(address(newEventContract)); 
    }

}