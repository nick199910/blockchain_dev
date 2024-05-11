const { ethers } = require("ethers");

// 连接对应的网络
const wsProviderUrl = 'wss://alien-withered-knowledge.bsc.quiknode.pro/e1331a9959057d304318812e77b40244528dd29a/';
const httpProviderUrl = 'https://alien-withered-knowledge.bsc.quiknode.pro/e1331a9959057d304318812e77b40244528dd29a/';


// 非流式读写交互

const http_provider = new ethers.JsonRpcProvider(httpProviderUrl);
const wss_provider = new ethers.WebSocketProvider(wsProviderUrl);


// 代币合约地址和ABI
const tokenAddress = '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c';
const tokenABI = [
    "function balanceOf(address account) external view returns (uint256)",
    "fucntion mint() external"
];



// 创建合约的实例
const tokenContract = new ethers.Contract(tokenAddress, tokenABI, http_provider);

// const pk = ''
// let wallet = new ethers.Wallet(privateKey, provider)
// const contract = new ethers.Contract( contractAddr,  Storage.abi,  wallet)
// const ret = await contract.mint();
// await ret.wait();


// 你想要查询余额的地址数组
const addresses = ['0x3b9899191410bCB2a31C6b721C202B4C03f83F2c', '0x0f0067cd819cB8F20BDa62046dAFF7a2b5c88280',
    '0x8D2b351E6519fc1251Fae1324eF357742A19c030', '0xc748f535E740850765B7364CC4bE5876853e34E1'];

// 定义一个异步函数来查询余额并计算总和
async function queryBalancesAndSum() {
    let totalBalance; // 初始化为undefined

    // 使其
    for (let address of addresses) {
        const balance = await tokenContract.balanceOf(address);
        // 在第一次迭代时初始化totalBalance，或者累加余额
        totalBalance = totalBalance ? totalBalance + balance : balance;
        console.log(`地址 ${address} 的余额是: ${ethers.formatEther(balance)} ether`);
    }

    console.log(`总余额是: ${ethers.formatEther(totalBalance)} ether`);
}

// 执行查询函数
queryBalancesAndSum().catch(console.error);