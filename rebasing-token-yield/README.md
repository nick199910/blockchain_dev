# Rebasing token with yield

## Rationale
Rebasing tokens are used to maintain peg to an underlying token and accrue yield. This is useful as users don't need to worry about the token's value
as it's always pegged, i.e stETH to ETH, USDY to USD. The mechanics of it is quite simple:
Alice makes a deposit to the protocol and she's minted shares proportional to the deposited amount in return. When a protocol receives yield either from trading
fees, lending or yield farming it transfers it to the rebasing token contract. User balances are recalculated automatically to account for it and they don't need to claim anything.

## Example
Let's look at an example with WETH (underlying token) and stETH (pegged token with yield):

1. Alice deposits 100 WETH and she's minted 100 shares in return. Since stETH is pegged her balance is 100 stETH.
2. Bob deposits 20 WETH and receives 20 shares. His balance is 20 stETH.
3. Contract Receives 60 WETH as yield so `balanceOf(Alice)` changes to 150 stETH, `balanceOf(Bob)` = 30. This is due to 5:1 ratio of deposited WETH. Total value hold is 180 WETH.
4. Next comes Charlie and deposits 60 WETH, now contract balance is 240 WETH. His stake is 25% so he's minted 40 shares and total shares increases to 160.
5. Alice is happy and withdraws 75 stETH of hers. She gets 75 WETH in return and her share drops to 1/2*100 = 50.

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```
