pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Event is ERC1155 {

    constructor(string memory uri) ERC1155(uri) {

    }
    
}
