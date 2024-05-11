// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MyProxy {
    uint256 public num;
    address public sender;
    uint256 public value;
    address public impl;

    function setImpl(address _addr) public {
        impl = _addr;
    }

    fallback() external {
        (bool success, bytes memory data) = impl.delegatecall(msg.data);
    }
}

contract MyImpl {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) public payable {
        // A's storage is set, B is not modified.
        num = _num;
    }
}
