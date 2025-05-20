// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script, console2} from "forge-std/Script.sol";
import {MoodNFT} from "../../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    MoodNFT moodNFT;

    function run() external returns (MoodNFT) {
        string memory sadSVG = vm.readFile("./images/DynamicNFT/sad.svg");
        string memory happySVG = vm.readFile("./images/DynamicNFT/happy.svg");
        vm.startBroadcast();
        moodNFT = new MoodNFT(svgToURi(sadSVG), svgToURi(happySVG));
        vm.stopBroadcast();
        return moodNFT;
    }

    function svgToURi(
        string memory _svgString
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            abi.encodePacked(_svgString)
        );
        return string.concat(baseURL, svgBase64Encoded);
    }
}
