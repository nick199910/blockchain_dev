// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;
import {Test, console} from "forge-std/Test.sol";

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        if (block.number > 10000) {
            number = (10 * newNumber) / newNumber;
            number = (10 * newNumber) / newNumber;
            number = (10 * newNumber) / newNumber;
            number = (10 * newNumber) / newNumber;
            number = (10 * newNumber) / newNumber;
        } else {
            console.log("111111111");
            uint x = 8 / newNumber;
            console.log("222222222");
            revert();
            console.log("333333333");
        }
    }

    function setBalance(uint256 newNumber) public payable {
        require(msg.value > 10000 ether);
        newNumber;
    }

    function increment() public {
        number++;
    }

    function decrement() public {
        number--;
    }
}
