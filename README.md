## IMP links

https://docs.aave.com/developers/deployed-contracts/v3-testnet-addresses
https://sepolia.etherscan.io/token/0xff34b3d4aee8ddcd6f9afffb6fe49bd371b8a357
https://gho.aave.com/faucet/

multiple: 0x8F4152Bbf9E333dD4b05879fD18714213e372EAF
simple: 0xDEDE73a9F316D554F4D17640b716d5ECA2aBb075

cast send $contract2 "requestFlashLoan(address[],uint256[])" "[0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357,0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0]" "[1000000000000000000,1000000]" --rpc-url $SEPOLIA_RPC_URL --account SEPO
