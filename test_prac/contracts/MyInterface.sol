// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface MY_IWETH9 {
    event Approval(address indexed src, address indexed guy, uint256 wad);
    event Deposit(address indexed dst, uint256 wad);
    event Transfer(address indexed src, address indexed dst, uint256 wad);
    event Withdrawal(address indexed src, uint256 wad);

    fallback() external payable;

    function allowance(address, address) external view returns (uint256);

    function approve(address guy, uint256 wad) external returns (bool);

    function balanceOf(address) external view returns (uint256);

    function decimals() external view returns (uint8);

    function deposit() external payable;

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function totalSupply() external view returns (uint256);

    function transfer(address dst, uint256 wad) external returns (bool);

    function transferFrom(
        address src,
        address dst,
        uint256 wad
    ) external returns (bool);

    function withdraw(uint256 wad) external;
}

interface MY_IUSDC {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event AuthorizationCanceled(
        address indexed authorizer,
        bytes32 indexed nonce
    );
    event AuthorizationUsed(address indexed authorizer, bytes32 indexed nonce);
    event Blacklisted(address indexed _account);
    event BlacklisterChanged(address indexed newBlacklister);
    event Burn(address indexed burner, uint256 amount);
    event MasterMinterChanged(address indexed newMasterMinter);
    event Mint(address indexed minter, address indexed to, uint256 amount);
    event MinterConfigured(address indexed minter, uint256 minterAllowedAmount);
    event MinterRemoved(address indexed oldMinter);
    event OwnershipTransferred(address previousOwner, address newOwner);
    event Pause();
    event PauserChanged(address indexed newAddress);
    event RescuerChanged(address indexed newRescuer);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event UnBlacklisted(address indexed _account);
    event Unpause();

    function CANCEL_AUTHORIZATION_TYPEHASH() external view returns (bytes32);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external view returns (bytes32);

    function RECEIVE_WITH_AUTHORIZATION_TYPEHASH()
        external
        view
        returns (bytes32);

    function TRANSFER_WITH_AUTHORIZATION_TYPEHASH()
        external
        view
        returns (bytes32);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function authorizationState(address authorizer, bytes32 nonce)
        external
        view
        returns (bool);

    function balanceOf(address account) external view returns (uint256);

    function blacklist(address _account) external;

    function blacklister() external view returns (address);

    function burn(uint256 _amount) external;

    function cancelAuthorization(
        address authorizer,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function cancelAuthorization(
        address authorizer,
        bytes32 nonce,
        bytes memory signature
    ) external;

    function configureMinter(address minter, uint256 minterAllowedAmount)
        external
        returns (bool);

    function currency() external view returns (string memory);

    function decimals() external view returns (uint8);

    function decreaseAllowance(address spender, uint256 decrement)
        external
        returns (bool);

    function increaseAllowance(address spender, uint256 increment)
        external
        returns (bool);

    function initialize(
        string memory tokenName,
        string memory tokenSymbol,
        string memory tokenCurrency,
        uint8 tokenDecimals,
        address newMasterMinter,
        address newPauser,
        address newBlacklister,
        address newOwner
    ) external;

    function initializeV2(string memory newName) external;

    function initializeV2_1(address lostAndFound) external;

    function initializeV2_2(
        address[] memory accountsToBlacklist,
        string memory newSymbol
    ) external;

    function isBlacklisted(address _account) external view returns (bool);

    function isMinter(address account) external view returns (bool);

    function masterMinter() external view returns (address);

    function mint(address _to, uint256 _amount) external returns (bool);

    function minterAllowance(address minter) external view returns (uint256);

    function name() external view returns (string memory);

    function nonces(address owner) external view returns (uint256);

    function owner() external view returns (address);

    function pause() external;

    function paused() external view returns (bool);

    function pauser() external view returns (address);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        bytes memory signature
    ) external;

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function receiveWithAuthorization(
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        bytes memory signature
    ) external;

    function receiveWithAuthorization(
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function removeMinter(address minter) external returns (bool);

    function rescueERC20(
        address tokenContract,
        address to,
        uint256 amount
    ) external;

    function rescuer() external view returns (address);

    function symbol() external view returns (string memory);

    function totalSupply() external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function transferOwnership(address newOwner) external;

    function transferWithAuthorization(
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        bytes memory signature
    ) external;

    function transferWithAuthorization(
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function unBlacklist(address _account) external;

    function unpause() external;

    function updateBlacklister(address _newBlacklister) external;

    function updateMasterMinter(address _newMasterMinter) external;

    function updatePauser(address _newPauser) external;

    function updateRescuer(address newRescuer) external;

    function version() external pure returns (string memory);
}

interface MY_IUniswapV2Router02 {
    receive() external payable;

    function WETH() external view returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function factory() external view returns (address);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountsIn(uint256 amountOut, address[] memory path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsOut(uint256 amountIn, address[] memory path)
        external
        view
        returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] memory path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external;

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external;

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] memory path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] memory path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}
