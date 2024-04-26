// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        // counter.setNumber(2);
    }

    // 初始状态(未执行setUp): A0  执行完setUp的状态: A1

    // function test_Increment() public {
    //     increment();
    //     assertEq(counter.number(), 3);
    // }

    // function increment() public {
    //     counter.increment();
    // }

    // function test_decrease() public {
    //     increment();
    //     counter.decrement();
    //     assertEq(counter.number(), 2);
    // }

    function test_setNumber() public {
        uint x = 1;
        vm.roll(16410700);
        deal(address(this), 10_000 ether);
        console.log("block.number: ", block.number);
        counter.setNumber(x);
        // assertEq(counter.number(), 9);
    }

    // // 模糊测试
    // function testFuzz_SetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), 10);
    // }

    function tttttts(uint x) public {}
}
