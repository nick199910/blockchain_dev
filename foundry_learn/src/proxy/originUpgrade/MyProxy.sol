// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MyProxy {
    // 0 - 2^256 - 1
    // storgae layout 要一致
    uint256 public num; // 第0个slot
    address public sender;
    uint256 public value; // 2 个 slot
    address public impl; // 相同
    address public owner;

    modifier onlyAdmin() {
        msg.sender == owner;
        _;
    }

    // 数据格式统一
    // https://mirror.xyz/xyyme.eth/5eu3_7f7275rqY-fNMUP5BKS8izV9Tshmv8Z5H9bsec
    function setImpl(address _addr) public onlyAdmin {
        impl = _addr;
    }

    fallback() external {
        (bool success, bytes memory data) = impl.delegatecall(msg.data);
    }
}

contract MyImpl {
    uint256 public _num0; // 第 0 个 slot
    address public sender;
    uint256 public value; // 2 个 slot

    function init() public {}

    function setVars(uint256 _num) public payable {
        // A's storage is set, B is not modified.
        _num0 = _num;
    }
}

contract MyImpl2 {
    uint256 public _num0; // 第 0 个 slot
    address public sender;
    uint256 public value; // 2 个 slot
    uint256 public value2; // 3 个 slot
    uint256 public value3; // 4 个 slot

    function setVars(uint256 _num) public payable {
        // A's storage is set, B is not modified.
        _num0 = _num;
    }
}
