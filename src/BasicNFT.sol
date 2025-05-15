/**
 * - Inside a sol file contract elements should be laid like this:
	1. Pragma statements
	2. Import statements
	3. Events
	4. Errors
	5. Interfaces
	6. Libraries
	7. Contracts
- Inside each contract we have this order of declaration:
	1. Type declaration
	2. State variables
	3. Events
	4. Errors
	5. Modifiers
	6. Functions
- Also functions inside a contract should be declared like this:
	1. constructor
	2. receive function (if exists)
	3. fallback function (if exists)
	4. external
	5. public
	6. internal
	7. private
	8. view & pure functions
 */
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

string constant baseCID = "QmYqgJgbiV1U1o3yHV41MPg7g6Nv8XjztqxH2hjNWU4Dch";

contract BasicNFT is ERC721 {
    /**State Variables */
    mapping(uint256 tokenID => string tokenURI) s_tokenIdToURI;
    uint256 private s_tokenCounter;

    /**Erorrs */
    error BasicNFT__InvalidTokenId(uint256 tokenId);

    //**Modifiers */
    modifier validTokenId(uint256 tokenId) {
        if (bytes(s_tokenIdToURI[tokenId]).length == 0) {
            revert BasicNFT__InvalidTokenId(tokenId);
        }
        _;
    }

    /**Functions */
    constructor() ERC721("Oreon", "OREO") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory _tokenURI) public {
        s_tokenIdToURI[s_tokenCounter] = _tokenURI; // Insert the given URI in the mapping at the current counter
        // used to generate unique token Ids
        _safeMint(msg.sender, s_tokenCounter); // mint the token id (current counter) to the sender of this transaction
        s_tokenCounter++; // update counter for future use
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override validTokenId(_tokenId) returns (string memory) {
        return s_tokenIdToURI[_tokenId];
    }
}
