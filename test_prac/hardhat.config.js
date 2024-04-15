require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.18",

    networks: {
      hardhat: {
        forking: {
          url: "https://lb.nodies.app/v1/181a5ebf4c954f8496ae7cbc1ac8d03b", 
        }
      }, 

    }
};
