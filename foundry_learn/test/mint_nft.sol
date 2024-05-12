// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {stdStorage, StdStorage} from "forge-std/Test.sol";
import {TT} from "src/mint/TestTT.sol";

interface INFT {
    function mint(
        uint32 qty,
        bytes32[] calldata proof,
        uint64 timestamp,
        bytes calldata signature
    ) external payable;

    function contractURI() external view returns (string memory);

    function balanceOf(address) external view returns (uint256);

    function owner() external view returns (address);
}

contract TestMintNft is Test {
    //
    INFT constant NFT = INFT(0x2A0c44ACe671744EDC884EA182Bea52cebAc5431);

    // test_block 19842446
    function setUp() public {
        vm.createSelectFork("mainnet", 19842346);
    }

    // function testExploit() public {
    //     //vm.startPrank(alice);
    //     //vm.stopPrank();
    //     hoax(address(this), 10 ether);
    //     address owner = NFT.owner();
    //     bytes32[] memory null_bytes = new bytes32[](1);
    //     (address alice, uint256 alicePk) = makeAddrAndKey("alice");
    //     emit log_address(alice);
    //     bytes32 hash = keccak256("Signed by Alice");
    //     (uint8 v, bytes32 r, bytes32 s) = vm.sign(alicePk, hash);
    //     bytes memory signature = abi.encodePacked(r, s, v);

    //     NFT.mint{value: 1 ether}(
    //         1,
    //         null_bytes,
    //         uint64(block.timestamp),
    //         signature
    //     );
    // }

    function test_tt() public {
        hoax(address(this), 100 ether);
        TT tt = new TT{value: 100 ether}();
        uint256 balance = NFT.balanceOf(address(tt));
        console2.log(balance);
    }

    // function onERC721Received(
    //     address operator,
    //     address from,
    //     uint256 tokenId,
    //     bytes calldata data
    // ) external returns (bytes4) {}
}
