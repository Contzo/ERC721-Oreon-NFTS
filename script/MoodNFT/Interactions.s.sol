// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../../src/MoodNFT.sol";
import {DevOpsTools} from "../../lib/foundry-devops/src/DevOpsTools.sol";

contract MintMoodNFT is Script {
    function run() external returns (uint256 _mintedId) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNFT",
            block.chainid
        );
        _mintedId = mintNFT(mostRecentlyDeployed);
    }

    function mintNFT(
        address _lastMoodNFTContract
    ) public returns (uint256 _mintedId) {
        MoodNFT moodNFTcontract = MoodNFT(_lastMoodNFTContract);
        vm.startBroadcast();
        _mintedId = moodNFTcontract.mintNFT();
        vm.stopBroadcast();
    }
}
