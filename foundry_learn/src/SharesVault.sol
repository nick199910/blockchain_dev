// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {ERC4626} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import {ERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SharesVault is ERC4626 {
    constructor(address _depositToken)
        ERC4626(IERC20(_depositToken))
        ERC20("Shares Vault", "SV")
    {}

    function shareProfits(uint256 amount) public {
        SafeERC20.safeTransferFrom(
            IERC20(asset()),
            msg.sender,
            address(this),
            amount
        );
    }
}
