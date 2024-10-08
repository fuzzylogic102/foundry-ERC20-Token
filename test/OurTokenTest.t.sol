// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {console} from "forge-std/Console.sol";

contract OurTokenTest is Test{
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public{
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowances() public {
    uint256 initialAllowance = 1000 ether;

    // Bob approves Alice to spend 1000 tokens on his behalf
    vm.prank(bob);
    ourToken.approve(alice, initialAllowance);

    uint256 transferAmount = 1 ether;

    // Alice tries to transfer 1 token from Bob to herself
    vm.prank(alice);
    ourToken.transferFrom(bob, alice, transferAmount);

    // Assert that the balances are as expected
    assertEq(ourToken.balanceOf(alice), transferAmount);
    assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

}