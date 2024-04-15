

const { ethers } = require("ethers");
const fs = require('fs');


// *** 使用说明: 在不同合约以及不同的链上使用的时候，注意要修改1, 2, 3, 4(4不是必须要修改的)

// *** 1. 填写要监听的链的rpc
const providerUrl = 'wss://blue-alpha-sun.quiknode.pro/d3d14459965006958b21114ac25db798a2df2d76/';
const provider = new ethers.WebSocketProvider(providerUrl);


// *** 2. 填写需要监听的合约地址
const contractAddress = '0xdAC17F958D2ee523a2206206994597C13D831ec7';


// *** 3. 填写需要监听的合约事件，注意事件必须存在于合约中才能监听到对应的事件
const abi = [
  "event Transfer(address indexed from, address indexed to, uint value)"
];

// 生成合约实例
const contractUSDT = new ethers.Contract(contractAddress, abi, provider);

const main = async () => {

  // Continuously listen to contract
  console.log("\n Using contract.on(), continuously listen to the Transfer event");
  contractUSDT.on('Transfer', (from, to, value)=>{
    console.log(
     // Print the result
     `${from} -> ${to} -> ${ethers.formatUnits(ethers.getBigInt(value),6)}`
    )
    
    // // *** 4. 填写自定义输出文件名 默认为 合约地址 + 监听事件
    // let output = contractAddress + 'Transfer' + '.txt'
    // fs.appendFileSync(output, `${from} -> ${to} -> ${ethers.formatUnits(ethers.getBigInt(value),18)}`);

  })

}

main()