// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../../script/BasicNFT/DeployBasicNFT.s.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT deployer;
    BasicNFT basicNFT;
    string oreonURI =
        "ipfs://QmRUsn4GCNV27AePabpPjwm3TeY6gANwFwcKkcVHieGamR/oreon.json";
    address owner1 = makeAddr("owner1");

    function setUp() external {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    /**Name and symbol test */
    function test_collectionName() external view {
        // Arrange / Action
        string memory expectedName = "Oreon";
        string memory collectionName = basicNFT.name();
        //Assert
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(collectionName))
        );
    }

    function test_NFTsymbol() external view {
        // Arrange / Act
        string memory expectedSymbol = "OREO";
        string memory symbol = basicNFT.symbol();
        //Assert
        assertEq(symbol, expectedSymbol);
    }

    /*//////////////////////////////////////////////////////////////
                              MINTING TEST
    //////////////////////////////////////////////////////////////*/

    function test_mintingAndHaveBalance() external {
        //Arrange
        vm.prank(owner1);
        //Act
        basicNFT.mintNFT(oreonURI);
        //Assert
        assert(basicNFT.balanceOf(owner1) == 1);
        assert(
            keccak256(abi.encodePacked(oreonURI)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
