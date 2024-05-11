// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibERC20} from "./LibERC20.sol";

// the ERC20 Token Facet contract which will be registered

contract ERC20Facet {
    function erc20mint(address to, uint256 amount) external {
        LibERC20.erc20mint(to, amount);
    }

    function erc20approve(address spender, uint256 amount) external {
        address owner = _msgSender();
        LibERC20.erc20approve(owner, spender, amount);
    }

    function erc20balanceOf(address account) external view returns (uint256) {
        return LibERC20.erc20balanceOf(account);
    }

    function erc20transfer(address to, uint256 amount) external returns (bool) {
        return LibERC20.erc20transfer(to, amount);
    }

    function erc20transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        address spender = _msgSender();
        return LibERC20.erc20transferFrom(spender, from, to, amount);
    }

    function _msgSender() private view returns (address) {
        return msg.sender;
    }
}
