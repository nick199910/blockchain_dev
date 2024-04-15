
// const hre = require("hardhat");
const { ethers } = require("ethers");

async function main() {

    // output = http output = socket
    
    const PRIVATE_KEY='40d9b99af969eb9326a1bfd01a18a51079822abc3e43bffe915a2e0c5655433e'
    
    const provider=new ethers.JsonRpcProvider("https://ethereum-sepolia.core.chainstack.com/1c6ca733dfdda561ba1c7a9e31f0d559");

    const signer=new ethers.Wallet(PRIVATE_KEY,provider)

    
    // const tx=await signer.sendTransaction({
    //   to:'0x17605FE331aa35a69026d18eB394f7D4F0a69945',
    //   value:ethers.parseUnits('0.001','ether')
    // })

    const tx=await signer.sendTransaction({
      to:'0x17605FE331aa35a69026d18eB394f7D4F0a69945',
      data: '0xd0e30db0',
      // value:ethers.parseUnits('0.001','ether')
    })
    
    let receipt = await provider.waitForTransaction(tx.hash);
    console.log("receipt: ", receipt);
    
    if (receipt.status === 1) {
      console.log("transaction successful!!!")
    } else {
      console.log("transaction fail!!!")
    }


    
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
