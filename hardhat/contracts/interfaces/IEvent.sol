// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;


interface IEvent {
    function getTicketPrice() external view returns(uint256);
}