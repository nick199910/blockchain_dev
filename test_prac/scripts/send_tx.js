
// const hre = require("hardhat");
const { ethers } = require("ethers");
const fs = require('fs');

// msg.sender == tx.origin （限制交易的发起者不能是合约地址）
//
async function main() {
  const provider = new ethers.JsonRpcProvider("https://rpc.taprootchain.io ");

  // 主钱包 
  const main_PRIVATE_KEY = 'fill your privateKey'

  const main_signer = new ethers.Wallet(main_PRIVATE_KEY, provider)


  //生成随机助记词并创建钱包
  let mnemonic = ethers.Mnemonic.fromEntropy(ethers.randomBytes(16))
  // let mnemonic = ethers.Mnemonic.fromEntropy(ethers.randomBytes(16), "www666888")  第二个参数是密码
  var path = "m/44'/60'/0'/0/0"
  // 通过助记词创建钱包
  let wallet = ethers.HDNodeWallet.fromMnemonic(mnemonic, path)

  console.log("账号地址: " + wallet.mnemonic.phrase, wallet.privateKey)
  let output = 'privateKey.txt'
  const PRIVATE_KEY = wallet.privateKey
  const phrase = wallet.mnemonic.phrase
  fs.appendFileSync(output, `${phrase}  =====   ${PRIVATE_KEY}\n`);


  const signer = new ethers.Wallet(PRIVATE_KEY, provider)

  const to_address = signer.address
  const transfer_tx = await main_signer.sendTransaction({
    to: to_address,
    value: ethers.parseUnits('2000', 'wei')
  })
  await transfer_tx.wait();
  console.log("====================== 转账成功 ======================")

  // eip1559 / 传统交易类型
  const tx = await signer.sendTransaction({
    to: '0x2dd53E7Cd5d6b206e3ACa05C7f22e3042d3a28e4',
    data: '0x4e71d92d',
    // 0x4e71d92d
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
