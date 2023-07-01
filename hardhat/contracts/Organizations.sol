// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable2Step.sol";


abstract contract Organizations is Ownable2Step {
    struct OrganizationEvents {
        mapping(uint256 => address) events;
        bool inWhitelist;
    }

    mapping (address => OrganizationEvents) internal organization;

    /** 
     * @custom:proposal банчами сделать?
    */
    function addVerifiedCompany(address _organization) public onlyOwner {
        organization[_organization].inWhitelist = true;
    }
    
    function deleteVerifiedCompany(address _organization) public onlyOwner {
        organization[_organization].inWhitelist = false;
    }
}