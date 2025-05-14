// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    string baseCID = "QmYqgJgbiV1U1o3yHV41MPg7g6Nv8XjztqxH2hjNWU4Dch";
    uint256 private s_tokenCounter;

    constructor() ERC721("Oreon", "OREO") {
        s_tokenCounter = 0;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {}
}
