// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../../script/MoodNFT/DeployMoodNFT.s.sol";
import {MoodNFT} from "../../src/MoodNFT.sol";

contract MoodNftIntegrationTest is Test {
    DeployMoodNFT deployer;
    MoodNFT _moodNft;
    address User = makeAddr("user");

    function setUp() external {
        deployer = new DeployMoodNFT();
        _moodNft = deployer.run();
    }

    function testViewTokenURIntegration() public {
        //Arrange
        vm.prank(User);
        //Act
        _moodNft.mintNFT();
        //Assert
        console2.log(_moodNft.tokenURI(0));
    }

    function testFlipTokenToSad() external {
        //Arrange
        vm.prank(User);
        _moodNft.mintNFT();
        //Act
        vm.prank(User);
        _moodNft.flipMood(0);

        //Assert
    }
}
