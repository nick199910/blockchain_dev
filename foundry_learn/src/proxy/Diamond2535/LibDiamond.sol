// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library LibDiamond {
    // Storage slots of this diamond
    // load the storge of the diamond contract at a specific location:
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.diamond.storage");

    event DiamondCut(FacetCut _diamondCut);
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    // 每一个切面下面对应的函数api
    struct FacetCut {
        address facetAddress; // address of the contract representing the facet of the diamond
        bytes4[] functionSelectors; // which functions from this new facet do we want registered
    }

    // Access existing facets and functions (aka selectors):
    // @note 这里的position 指的是 函数选择器在函数选择器数组中的位置
    struct FacetAddressAndPosition {
        address facetAddress;
        uint96 functionSelectorPosition; // position in facetFunctionSelectors.functionSelectors array
    }

    struct FacetFunctionSelectors {
        bytes4[] functionSelectors;
        uint256 facetAddressPosition;
    }

    // general diamond storage space
    struct DiamondStorage {
        // maps function selector to the facet address and
        // the position of the selector in the facetFunctionSelectors.selectors array

        // 当前的selector 在当前的切面下的数组中的位置
        mapping(bytes4 => FacetAddressAndPosition) selectorToFacetAndPosition;
        // maps facet addresses to function selectors

        // 当前的切面的切面是第一切面，同时该切面下对应的selector
        mapping(address => FacetFunctionSelectors) FacetFunctionSelectors;
        // facet addresses
        address[] facetAddresses;
        // owner of the diamond contract
        address contractOwner;
    }

    // access core storage via;
    function diamondStorage()
        internal
        pure
        returns (DiamondStorage storage ds)
    {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    // 向砖石里面插入一个新的切面
    // @note 如果想要在切面中加入一些新的函数呢?
    // The main function that is used to cut new facets into the diamond (aka add a new contract and its functions to the diamond)
    function diamondCut(FacetCut calldata _diamondCut) internal {
        address facetAddress = _diamondCut.facetAddress;
        bytes4[] memory functionSelectors = _diamondCut.functionSelectors;

        require(
            functionSelectors.length > 0,
            "LibDiamondCut: No selectors in facet to cut"
        );
        require(
            facetAddress != address(0),
            "LibDiamondCut: Add facet can't be address(0)"
        );

        DiamondStorage storage ds = diamondStorage();

        // Where are we in the selector array under this facet?
        // 当前切面下放置了多少个函数 选择器
        uint96 selectorPosition = uint96(
            ds.FacetFunctionSelectors[facetAddress].functionSelectors.length
        );

        // add new facet address if it does not exist
        if (selectorPosition == 0) {
            _enforceHasContractCode(
                facetAddress,
                "LibDiamondCut: New facet has no code"
            );

            // store facet address
            ds.FacetFunctionSelectors[facetAddress].facetAddressPosition = ds
                .facetAddresses
                .length;

            ds.facetAddresses.push(facetAddress);
        }

        // add each new incoming function selector to this facet
        for (
            uint256 selectorIndex;
            selectorIndex < functionSelectors.length;
            selectorIndex++
        ) {
            bytes4 selector = functionSelectors[selectorIndex];

            // ensure the facet does not already exist;
            address currentFacetAddressIfAny = ds
                .selectorToFacetAndPosition[selector]
                .facetAddress;
            require(
                currentFacetAddressIfAny == address(0),
                "LibDiamondCut: Can't add function that already exists"
            );

            // ADD the function (selector) here
            // map the selec tor to the position
            ds
                .selectorToFacetAndPosition[selector]
                .functionSelectorPosition = selectorPosition;
            ds.selectorToFacetAndPosition[selector].facetAddress = facetAddress;
            // we track the selectors in an array under the facet address
            ds.FacetFunctionSelectors[facetAddress].functionSelectors.push(
                selector
            );
            selectorPosition++;
        }
        emit DiamondCut(_diamondCut);
    }

    // Core Diamond State
    // core diamond contract ownership
    function setContractOwner(address _newOwner) internal {
        DiamondStorage storage ds = diamondStorage();
        address previousOwner = ds.contractOwner;
        ds.contractOwner = _newOwner;
        emit OwnershipTransferred(previousOwner, _newOwner);
    }

    function contractOwner() internal view returns (address) {
        return diamondStorage().contractOwner;
    }

    function enforceIsContractOwner() internal view {
        require(
            _msgSender() == contractOwner(),
            "LibDiamond: Must be contract owner"
        );
    }

    // private functions in this section
    function _enforceHasContractCode(
        address _contract,
        string memory _errorMessage
    ) private view {
        uint256 contractSize;
        assembly {
            contractSize := extcodesize(_contract)
        }
        require(contractSize > 0, _errorMessage);
    }

    function _msgSender() private view returns (address) {
        // put msg.sender behind a private view wall
        return msg.sender;
    }
}
