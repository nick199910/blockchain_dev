pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/RebasingToken.sol";
import "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract RebasingTokenTest is Test {
  RebasingToken public steth;
  ERC20Mock public weth;
  address alice = address(1);
  address bob = address(2);
  address charlie = address(3);
  function setUp() public {
    weth = new ERC20Mock();
    steth = new RebasingToken("stETH", "staked ETH", weth);
    weth.mint(alice, 100 ether);
    weth.mint(bob, 20 ether);
    weth.mint(charlie, 60 ether);
  }

  function testInitial() public {
    vm.startPrank(alice);
    weth.approve(address(steth), 100 ether);
    steth.deposit(100 ether);
    vm.startPrank(bob);
    weth.approve(address(steth), 20 ether);
    steth.deposit(20 ether);
    vm.stopPrank();
    assertEq(steth.totalSupply(), 120 ether);
    assertEq(steth.balanceOf(alice), 100 ether);
    assertEq(steth.sharesOf(alice), 100 ether);
    assertEq(steth.balanceOf(bob), 20 ether);
    assertEq(steth.sharesOf(bob), 20 ether);
  }

  function testAfterYield() public {
    testInitial();
    weth.mint(address(steth), 60 ether);
    // now totalWETH = 180 ether. alice vs bob ratio = 5:1
    assertEq(steth.totalSupply(), 120 ether);
    assertEq(steth.balanceOf(alice), 150 ether);
    // shares hasn't changed
    assertEq(steth.sharesOf(alice), 100 ether);
    assertEq(steth.balanceOf(bob), 30 ether);
    // shares hasn't changed
    assertEq(steth.sharesOf(bob), 20 ether);
  }

  function testAfterCharlie() public {
    testAfterYield();
    vm.startPrank(charlie);
    weth.approve(address(steth), 60 ether);
    steth.deposit(60 ether);
    vm.stopPrank();
    // charlie will be minted 40 shares
    assertEq(steth.totalSupply(), 160 ether);
    assertEq(steth.sharesOf(charlie), 40 ether);
    assertEq(steth.balanceOf(alice), 150 ether);
    assertEq(steth.balanceOf(bob), 30 ether);
    assertEq(steth.balanceOf(charlie), 60 ether);

  }

  function testAfterWithdraw() public {
    testAfterCharlie();
    vm.prank(alice);
    steth.withdraw(75 ether);
    assertEq(weth.balanceOf(alice), 75 ether);
    assertEq(steth.balanceOf(alice), 75 ether);
    assertEq(steth.sharesOf(alice), 50 ether);
    // unchanged
    assertEq(steth.balanceOf(bob), 30 ether);
    assertEq(steth.sharesOf(bob), 20 ether);
    assertEq(steth.balanceOf(charlie), 60 ether);
    assertEq(steth.sharesOf(charlie), 40 ether);
  }
}

//x/(120+x)=1/4=>4x=120+x=>x=40