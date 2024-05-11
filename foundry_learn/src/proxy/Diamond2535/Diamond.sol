// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibDiamond} from "./LibDiamond.sol";

contract Diamond {
    constructor(address _contractOwner) payable {
        LibDiamond.setContractOwner(_contractOwner);
    }

    // Cut new facets into this diamond
    // 创建一个切面
    // proxy -> 逻辑
    // 多个代理合约 -> 一个逻辑合约
    function diamondCut(LibDiamond.FacetCut calldata _diamondCut) external {
        // only the diamond owner can cut new facets
        LibDiamond.enforceIsContractOwner();
        // cut the facet into the diamond
        LibDiamond.diamondCut(_diamondCut);
    }

    // Find facet for function that is called and execute the
    // function if a facet is found and return any value

    fallback() external payable {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();

        // get facet from function selector (which is == msg.sig)
        address facet = ds.selectorToFacetAndPosition[msg.sig].facetAddress;
        require(facet != address(0), "Diamond: function does not exist");

        // Execute external function from facet using delegatecall and return any value.
        assembly {
            // copy function selector and any arguments
            calldatacopy(0, 0, calldatasize()) // copies the calldata into memory (this is where delegatecall loads from)
            // execute function call against the relevant facet
            // note that we send in the entire calldata including the function selector
            let result := delegatecall(gas(), facet, 0, calldatasize(), 0, 0)
            // get any return value
            returndatacopy(0, 0, returndatasize())
            // return any return value or error back to the caller
            switch result
            case 0 {
                // delegate call failed
                revert(0, returndatasize()) // so revert
            }
            default {
                return(0, returndatasize()) // delegatecall succeeded, return any return data
            }
        }
    }

    receive() external payable {}
}
