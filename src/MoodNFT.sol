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
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    /*//////////////////////////////////////////////////////////////
                                 TYPES
    //////////////////////////////////////////////////////////////*/
    enum Mood {
        HAPPY,
        SAD
    }

    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    uint256 private s_tokenCounter;
    string private s_happySVG;
    string private s_sadSVG;
    mapping(uint256 tokenID => string tokenURI) s_tokenIdToURI;
    mapping(uint256 tokenId => Mood) s_tokenIdMood;

    /*//////////////////////////////////////////////////////////////
                             CUSTOM ERRORS
    //////////////////////////////////////////////////////////////*/
    error MoodNFT__InvalidTokenId(uint256 tokenId);
    error MoodNFT__CantFlipMoodIfNotOwner();

    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/
    modifier validTokenId(uint256 tokenId) {
        if (bytes(s_tokenIdToURI[tokenId]).length == 0) {
            revert MoodNFT__InvalidTokenId(tokenId);
        }
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    constructor(
        string memory _sadSVGImageURI,
        string memory _happySVGImageURI
    ) ERC721("MoodNFT", "MDNFT") {
        s_tokenCounter = 0;
        s_happySVG = _happySVGImageURI;
        s_sadSVG = _sadSVGImageURI;
    }

    /**Public functions */
    function mintNFT() public returns (uint256 mintedTokenId) {
        _safeMint(msg.sender, s_tokenCounter); // mint the token id (current counter) to the sender of this transaction
        s_tokenIdMood[s_tokenCounter] = Mood.HAPPY;
        mintedTokenId = s_tokenCounter;
        s_tokenCounter++; // update counter for future use
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdMood[_tokenId] == Mood.HAPPY) {
            imageURI = s_happySVG;
        } else {
            imageURI = s_sadSVG;
        }
        return
            string.concat(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name": "',
                        name(),
                        '", "description": "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                        imageURI,
                        '"}'
                    )
                )
            );
    }

    /**
     * @dev Allows the user of the `_tokenId` NFT to flip associated image
     */
    function flipMood(uint256 _tokenId) public {
        if (_ownerOf(_tokenId) != msg.sender) {
            revert MoodNFT__CantFlipMoodIfNotOwner(); // check if the account that wants to flip the mood is the actual owner
        }
        // flip the mood of the NFT
        s_tokenIdMood[_tokenId] = s_tokenIdMood[_tokenId] == Mood.HAPPY
            ? Mood.SAD
            : Mood.HAPPY;
    }

    /**View/Pure functions*/
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}
