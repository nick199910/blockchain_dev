const { ethers } = require("ethers");


// const selctor = ethers.id('claim(address _addr)').substring(0, 10);

const selector = ethers.FunctionFragment.getSelector('claim', ['address']) // '0x40c10f19'
console.log(selector)
const abiCode = new ethers.AbiCoder()
const param = abiCode.encode(['address'], ['0x6a3204b43ea7d3e79e54168bb0c70cd668ecd1d3']).substring(2,);

const calldata = selector + param;
console.log(calldata)


const tx = await signer.sendTransaction({
    to: '0x2dd53E7Cd5d6b206e3ACa05C7f22e3042d3a28e4',
    data: '0x4e71d92d',
    // 0x4e71d92d
    // value:ethers.parseUnits('0.001','ether')
})

// https://docs.ethers.org/v5/api/providers/provider/#Provider-estimateGas
// await provider.call