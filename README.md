# blast-contracts
 Smartcontracts with create token, token miner and game "Rock, paper, scissors" for Blast testnet.

## actions
1. Install in with folder:
npm install
2. Open config.json file:
2.1. Add private key for deployments in pkey;
2.2. Change contract name in the MinersCreator:
MinersCreator or tokenFactory.
2.3. If you are added tokenFactory in contractName, change solidity version in "solidity" to 0.8.0.
For MinersCreator - 0.8.1
3. Run deploy and verify:
<code>npx hardhat run --network blastSepolia scripts/deploy.ts</code>

That is all.

[Github of site with this smartcontracts](https://github.com/denis-skripnik/dpos.space), [deractory of pages](https://github.com/denis-skripnik/dpos.space/tree/master/blockchains/evm).
[Game contract](https://github.com/denis-skripnik/rockPaperScissors).