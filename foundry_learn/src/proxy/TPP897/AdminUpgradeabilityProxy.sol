// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {UpgradeabilityProxy} from "./UpgradeabilityProxy.sol";

// 加入了升级逻辑合约的管理员
contract AdminUpgradeabilityProxy is UpgradeabilityProxy {
    event AdminChanged(address previousAdmin, address newAdmin);

    bytes32 private constant ADMIN_SLOT =
        0x10d6a54a4754c8869d6886b5f5d7fbfa5b4522237ea5c60d11bc4e7a1ff9390b;

    modifier ifAdmin() {
        if (msg.sender == _admin()) {
            _;
        } else {
            _fallback();
        }
    }

    constructor(address implementationContract)
        UpgradeabilityProxy(implementationContract)
    {
        assert(ADMIN_SLOT == keccak256("org.zeppelinos.proxy.admin"));

        _setAdmin(msg.sender);
    }

    function admin() external view returns (address) {
        return _admin();
    }

    function implementation() external view returns (address) {
        return _implementation();
    }

    function changeAdmin(address newAdmin) external ifAdmin {
        require(
            newAdmin != address(0),
            "Cannot change the admin of a proxy to the zero address"
        );
        emit AdminChanged(_admin(), newAdmin);
        _setAdmin(newAdmin);
    }

    function upgradeTo(address newImplementation) external ifAdmin {
        _upgradeTo(newImplementation);
    }

    function upgradeToAndCall(address newImplementation, bytes calldata data)
        external
        payable
        ifAdmin
    {
        _upgradeTo(newImplementation);
        (bool success, ) = address(this).call{value: msg.value}(data);
        require(success);
    }

    // The admin slot
    function _admin() internal view returns (address adm) {
        bytes32 slot = ADMIN_SLOT;
        assembly {
            adm := sload(slot)
        }
    }

    // Sets the address of the proxy admin
    // newAdmin Address of the new proxy admin
    function _setAdmin(address newAdmin) internal {
        bytes32 slot = ADMIN_SLOT;
        assembly {
            sstore(slot, newAdmin)
        }
    }

    // Only fall back when the sender is not the admin.
    function _willFallback() internal override {
        require(
            msg.sender != _admin(),
            "Cannot call fallback function from the proxy admin"
        );
        super._willFallback();
    }
}
