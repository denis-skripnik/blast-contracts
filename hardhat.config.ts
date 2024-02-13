import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';
import '@nomicfoundation/hardhat-verify';
import { pkey, solidity } from './config.json';

const config: HardhatUserConfig = {
  solidity,
  etherscan: {
    apiKey: {
      blastSepolia: 'your API key'
    },
    customChains: [
      {
        network: 'blastSepolia',
        chainId: 168587773,
        urls: {
          apiURL: 'https://api.routescan.io/v2/network/testnet/evm/168587773/etherscan',
          browserURL: 'https://testnet.blastscan.io'
        }
      }
    ]
  },
  networks: {
    blastSepolia: {
      url: 'https://sepolia.blast.io',
      accounts: [pkey]
    },
  },
};

export default config;