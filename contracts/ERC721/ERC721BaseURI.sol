// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";

abstract contract ERC721BaseURI is ERC721 {
    string private baseURI;

    function getBaseURI() external view returns(string memory) {
      return _baseURI();
    }

    function _setBaseURI(string memory baseURI_) internal virtual {
        baseURI = baseURI_;
    }

    function _baseURI() internal view virtual override returns(string memory) {
        return baseURI;
    }

}