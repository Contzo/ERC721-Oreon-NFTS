// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../../script/MoodNFT/DeployMoodNFT.s.sol";
import {MoodNFT} from "../../src/MoodNFT.sol";
import {FlipNFTMood} from "../../script/MoodNFT/Interactions.s.sol";

contract MoodNftIntegrationTest is Test {
    DeployMoodNFT deployer;
    MoodNFT _moodNft;
    address User = makeAddr("user");
    string constant SVG_SAD_URI =
        "data:application/json;base64,eyJuYW1lIjogIk1vb2RORlQiLCAiZGVzY3JpcHRpb24iOiAiQW4gTkZUIHRoYXQgcmVmbGVjdHMgdGhlIG93bmVycyBtb29kLiIsICJhdHRyaWJ1dGVzIjogW3sidHJhaXRfdHlwZSI6ICJtb29kaW5lc3MiLCAidmFsdWUiOiAxMDB9XSwgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjNhV1IwYUQwaU1UQXlOSEI0SWlCb1pXbG5hSFE5SWpFd01qUndlQ0lnZG1sbGQwSnZlRDBpTUNBd0lERXdNalFnTVRBeU5DSWdlRzFzYm5NOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6SXdNREF2YzNabklqNDhjR0YwYUNCbWFXeHNQU0lqTXpNeklpQmtQU0pOTlRFeUlEWTBRekkyTkM0MklEWTBJRFkwSURJMk5DNDJJRFkwSURVeE1uTXlNREF1TmlBME5EZ2dORFE0SURRME9DQTBORGd0TWpBd0xqWWdORFE0TFRRME9GTTNOVGt1TkNBMk5DQTFNVElnTmpSNmJUQWdPREl3WXkweU1EVXVOQ0F3TFRNM01pMHhOall1Tmkwek56SXRNemN5Y3pFMk5pNDJMVE0zTWlBek56SXRNemN5SURNM01pQXhOall1TmlBek56SWdNemN5TFRFMk5pNDJJRE0zTWkwek56SWdNemN5ZWlJdlBqeHdZWFJvSUdacGJHdzlJaU5GTmtVMlJUWWlJR1E5SWswMU1USWdNVFF3WXkweU1EVXVOQ0F3TFRNM01pQXhOall1Tmkwek56SWdNemN5Y3pFMk5pNDJJRE0zTWlBek56SWdNemN5SURNM01pMHhOall1TmlBek56SXRNemN5TFRFMk5pNDJMVE0zTWkwek56SXRNemN5ZWsweU9EZ2dOREl4WVRRNExqQXhJRFE0TGpBeElEQWdNQ0F4SURrMklEQWdORGd1TURFZ05EZ3VNREVnTUNBd0lERXRPVFlnTUhwdE16YzJJREkzTW1ndE5EZ3VNV010TkM0eUlEQXROeTQ0TFRNdU1pMDRMakV0Tnk0MFF6WXdOQ0EyTXpZdU1TQTFOakl1TlNBMU9UY2dOVEV5SURVNU4zTXRPVEl1TVNBek9TNHhMVGsxTGpnZ09EZ3VObU10TGpNZ05DNHlMVE11T1NBM0xqUXRPQzR4SURjdU5FZ3pOakJoT0NBNElEQWdNQ0F4TFRndE9DNDBZelF1TkMwNE5DNHpJRGMwTGpVdE1UVXhMallnTVRZd0xURTFNUzQyY3pFMU5TNDJJRFkzTGpNZ01UWXdJREUxTVM0MllUZ2dPQ0F3SURBZ01TMDRJRGd1TkhwdE1qUXRNakkwWVRRNExqQXhJRFE0TGpBeElEQWdNQ0F4SURBdE9UWWdORGd1TURFZ05EZ3VNREVnTUNBd0lERWdNQ0E1Tm5vaUx6NDhjR0YwYUNCbWFXeHNQU0lqTXpNeklpQmtQU0pOTWpnNElEUXlNV0UwT0NBME9DQXdJREVnTUNBNU5pQXdJRFE0SURRNElEQWdNU0F3TFRrMklEQjZiVEl5TkNBeE1USmpMVGcxTGpVZ01DMHhOVFV1TmlBMk55NHpMVEUyTUNBeE5URXVObUU0SURnZ01DQXdJREFnT0NBNExqUm9ORGd1TVdNMExqSWdNQ0EzTGpndE15NHlJRGd1TVMwM0xqUWdNeTQzTFRRNUxqVWdORFV1TXkwNE9DNDJJRGsxTGpndE9EZ3VObk01TWlBek9TNHhJRGsxTGpnZ09EZ3VObU11TXlBMExqSWdNeTQ1SURjdU5DQTRMakVnTnk0MFNEWTJOR0U0SURnZ01DQXdJREFnT0MwNExqUkROalkzTGpZZ05qQXdMak1nTlRrM0xqVWdOVE16SURVeE1pQTFNek42YlRFeU9DMHhNVEpoTkRnZ05EZ2dNQ0F4SURBZ09UWWdNQ0EwT0NBME9DQXdJREVnTUMwNU5pQXdlaUl2UGp3dmMzWm5QZz09In0=";

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
        assertEq(
            keccak256(abi.encodePacked(_moodNft.tokenURI(0))),
            keccak256(abi.encodePacked(SVG_SAD_URI))
        );
    }
}
