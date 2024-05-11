// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {MyProxy, MyImpl} from "src/proxy/originUpgrade/MyProxy.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {stdStorage, StdStorage} from "forge-std/Test.sol";

contract TestMyProxy is Test {
    MyProxy public my_proxy;
    MyImpl public my_impl;

    function setUp() public {
        my_impl = new MyImpl();
        my_proxy = new MyProxy();
        my_proxy.setImpl(address(my_impl));
    }

    function test_set_value() public {
        // my_proxy.setVars(2);
        uint256 num_value = 123;
        (bool success, bytes memory data) = address(my_proxy).call(
            (abi.encodeWithSignature("setVars(uint256)", 123))
        );
        require(success == true);
        uint256 num_slot = 0;
        assertEq(
            uint256(vm.load(address(my_proxy), bytes32(num_slot))),
            num_value
        );
        // assertEq(
        //     uint256(vm.load(address(my_impl), bytes32(num_slot))),
        //     num_value
        // );
    }
}
