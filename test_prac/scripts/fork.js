const { ethers, network, artifacts } = require('hardhat')
const {helpers} = require("@nomicfoundation/hardhat-toolbox/network-helpers");

const address = "0x1234567890123456789012345678901234567890";

WETH_ADDRESS= '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'
USDC_ADDRESS= '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'
ROUTER_ADDRESS = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D'

const main = async () => {
    // 1. 得到对应网络的signer
    const [signer] = await ethers.getSigners()
    console.log(signer.address)

    // 2. 模拟V神的账户
    // Vitalik: 0xab5801a7d398351b8be11c439e05c5b3259aec9b
    const VitalikAddress = '0xab5801a7d398351b8be11c439e05c5b3259aec9b'
    // await helpers.impersonateAccount(VitalikAddress);
    // const VitalikSigner = await ethers.getSigner(VitalikAddress);
    const VitalikSigner = await ethers.getImpersonatedSigner(VitalikAddress);

    // 3. get Balance


    // const VitalikEthBalance1 = await network.provider.request({
    //     method: 'eth_getBalance',
    //     params: [
    //         VitalikAddress
    //     ],
    // });



    const router = await ethers.getContractAt("MY_IUniswapV2Router02", ROUTER_ADDRESS, VitalikSigner)
    const usdc = await ethers.getContractAt("MY_IUSDC", USDC_ADDRESS, VitalikSigner)
    const weth = await ethers.getContractAt("MY_IWETH9", WETH_ADDRESS, VitalikSigner)

    const wVitalikEthBalanceBefore = await weth.balanceOf(VitalikAddress);
    const VitalikEthBalanceBefore = await ethers.provider.getBalance(VitalikAddress);
    console.log("V 神 ETH 余额: ", ethers.formatEther(VitalikEthBalanceBefore))
    console.log("V 神 WETH 余额: ", ethers.formatEther(wVitalikEthBalanceBefore), "\n")

    let tx = await weth.deposit({
        value: ethers.parseEther('1')
    });
    await tx.wait()

    // connect (signer)
    // let tx = await weth.connect(signer).deposit({
    //     value: ethers.parseEther('1')
    // });
    // await tx.wait()

    const wVitalikEthBalanceAfter = await weth.balanceOf(VitalikAddress);
    const VitalikEthBalanceAfter = await ethers.provider.getBalance(VitalikAddress);
    console.log("V 神 ETH 余额: ", ethers.formatEther(VitalikEthBalanceAfter))
    console.log("V 神 WETH 余额: ", ethers.formatEther(wVitalikEthBalanceAfter), "\n")

    console.log("=====================================================================")
    const VitalikUSDCBalanceBefore = await usdc.balanceOf(VitalikAddress);
    console.log("Swap 之前 V 神 USDC 余额: ", ethers.formatUnits(VitalikUSDCBalanceBefore, 6))
    console.log("Swap 之前 V 神 WETH 余额: ", ethers.formatEther(wVitalikEthBalanceAfter), "\n")
    let amountIn = ethers.parseEther('100');
    let tx_approve = await weth.approve(ROUTER_ADDRESS, amountIn);
    await tx_approve.wait();
    const tx2 = await router.swapExactTokensForTokens(
        amountIn,
        0,
        [WETH_ADDRESS, USDC_ADDRESS],
        VitalikAddress,
        Math.floor(Date.now() / 1000) + (60 * 10),
        {
            gasLimit: 1000000,
        }
    );
    await tx2.wait()
    const VitalikUSDCBalanceAfter = await usdc.balanceOf(VitalikAddress);
    const swapWVitalikEthBalanceAfter = await weth.balanceOf(VitalikAddress);
    console.log("Swap 之后 V 神 USDC 余额: ", ethers.formatUnits(VitalikUSDCBalanceAfter, 6))
    console.log("Swap 之后 V 神 WETH 余额: ", ethers.formatEther(swapWVitalikEthBalanceAfter), "\n")
  
}
main()

/*
node scripts/01_v2Swap.js
*/