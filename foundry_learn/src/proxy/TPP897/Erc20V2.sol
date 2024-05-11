pragma solidity ^0.8.13;

import {ERC20} from "lib/solmate/src/tokens/ERC20.sol";

contract TppTokenV2 is ERC20 {
    // 对deposit_token实现eip712
    constructor() ERC20("PT", "PT", 18) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function mintMulti(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
