// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "forge-std/console.sol";

library Error {
  error WithdrawAmountGreaterThanBalance();
}

// Rebasing token accrues yield and maintains it's peg to the underlying
// Users are minted shares proportional to the deposited amount
// When they withdraw they get the underlying token + accrued yield

contract RebasingToken is ERC20, Ownable {
  using SafeERC20 for IERC20;
  uint public immutable PRECISION = 1_000;
  IERC20 public underlying;

  constructor(string memory name, string memory symbol, IERC20 _underlying)
    ERC20(name, symbol) Ownable(msg.sender) {
    underlying = _underlying;
  }

  function deposit(uint amount) external {
    // user deposits amount of underlying token
    underlying.safeTransferFrom(msg.sender, address(this), amount);
    uint underlyingBalance = underlying.balanceOf(address(this));
    if (underlyingBalance == amount) {
      // first deposit
      _mint(msg.sender, amount);
    } else {
      _mint(msg.sender, totalSupply() * PRECISION / (underlying.balanceOf(address(this)) * PRECISION / amount - PRECISION));
    }
  }

  function withdraw(uint amount) external {
    // user withdraws amount of token
    if (amount > balanceOf(msg.sender)) {
      revert Error.WithdrawAmountGreaterThanBalance();
    }
    uint sharesToBurn = totalSupply() * amount / underlying.balanceOf(address(this));
    _burn(msg.sender, sharesToBurn);
    underlying.transfer(msg.sender, amount);
  }

  function sharesOf(address a) public view returns(uint) {
    return super.balanceOf(a);
  }

  function balanceOf(address a) public view override returns(uint) {
    return underlying.balanceOf(address(this)) * sharesOf(a) / totalSupply();
  }
}