// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "lib/forge-std/src/Test.sol";

abstract contract Proxy {
    fallback() external payable {
        _fallback();
    }

    function _implementation() internal view virtual returns (address);

    function _delegate(address implemention) internal {
        assembly {
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(
                gas(),
                implemention,
                0,
                calldatasize(),
                0,
                0
            )

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    // 作为钩子函数在派生合约中重新定义
    function _willFallback() internal virtual {}

    function _fallback() internal {
        _willFallback();
        _delegate(_implementation());
    }
}
