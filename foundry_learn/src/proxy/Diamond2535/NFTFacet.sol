// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibERC20} from "./LibERC20.sol";
import {LibNFT} from "./LibNFT.sol";

contract NFTFacet {
    function mint(address to, uint256 tokenId) public {
        LibNFT.mint(to, tokenId);
    }

    function ownerOf(uint256 tokenId) external view returns (address) {
        return LibNFT.ownerOf(tokenId);
    }

    function burn(uint256 tokenId) external {
        LibNFT.burn(tokenId);
    }

    function balanceOf(address owner) external view returns (uint256) {
        return LibNFT.balanceOf(owner);
    }

    function transfer(address to, uint256 tokenId) external {
        LibNFT.transfer(msg.sender, to, tokenId);
    }

    function mintWithERC20(uint256 tokenId) external {
        // mint an NFT via the ERC20
        LibERC20.erc20approve(msg.sender, address(this), LibNFT.COST);
        LibERC20.erc20transferFrom(
            address(this),
            msg.sender,
            address(this),
            LibNFT.COST
        );
    }

    function _msgSender() private view returns (address) {
        return msg.sender;
    }
}
