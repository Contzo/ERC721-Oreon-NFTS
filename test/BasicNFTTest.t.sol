// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT deployer;
    BasicNFT basicNFT;
    address owner1 = makeAddr("owner1");

    function setUp() external {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    /**Name and symbol test */
    function test_colectionName() external view {
        // Arrange / Action
        string memory collectionName = basicNFT.name();
        //Assert
        assertEq(collectionName, "Oreon");
    }
}
