// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {DeployMoodNFT} from "../../script/MoodNFT/DeployMoodNFT.s.sol";

contract MoodNftTest is Test {
    MoodNFT moodNft;
    address public USER = makeAddr("USER");
    DeployMoodNFT deployScript;

    function setUp() external {
        deployScript = new DeployMoodNFT();
        moodNft = deployScript.run();
    }

    function test_tokeURI() external {
        vm.prank(USER);
        moodNft.mintNFT();
        console2.log(moodNft.tokenURI(0));
    }
}
