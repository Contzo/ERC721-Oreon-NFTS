// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../../script/MoodNFT/DeployMoodNFT.s.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoonNFTDeployTest is Test {
    DeployMoodNFT deployScript;

    function setUp() external {
        deployScript = new DeployMoodNFT();
    }

    function test_svgToImage() external view {
        string
            memory svg = '<svg viewBox="0 0 200 200" width="400"  height="400" xmlns="http://www.w3.org/2000/svg"><circle cx="100" cy="100" fill="yellow" r="78" stroke="black" stroke-width="3"/><g class="eyes"><circle cx="70" cy="82" r="12"/><circle cx="127" cy="82" r="12"/></g><path d="m136.81 116.53c.69 26.17-64.11 42-81.52-.73" style="fill:none; stroke: black; stroke-width: 3;"/></svg>';
        string memory expectedEncodedSvg = Base64.encode(bytes(svg));

        string memory actualEncodedUri = deployScript.svgToURi(svg);
        string memory expectedUri = string.concat(
            "data:image/svg+xml;base64,",
            expectedEncodedSvg
        );

        console2.log(actualEncodedUri);
        assertEq(actualEncodedUri, expectedUri);
    }
}
