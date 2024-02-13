import { ethers, run } from "hardhat";
import { contractName } from "../config.json";

async function main() {
  const contract = await ethers.deployContract(contractName);
   const WAIT_BLOCK_CONFIRMATIONS = 6;
    await contract.waitForDeployment();
  await new Promise(r => setTimeout(r, 10000));
  let contract_address = contract.address;
  if (!contract.address) contract_address = contract.target;
  console.log(
    `Deployed to ${contract_address}`);
     await run(`verify:verify`, {address: contract_address});
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
