-include .env

.PHONY: all test deploy

build :; forge build 

test :; forge test 

install :; forge install foundry-rs/forge-std --no-commit && forge install OpenZeppelin/openzeppelin-contracts --no-commit && forge install Cyfrin/foundry-devops --no-commit


deploy-sepolia:
	@forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url $(SEPOLIA_RPC_URL) --account SepoliaDummyAccountKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-anvil:
	@forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url $(ANVIL_RPC_URL) --account defaultAnvilWallet --broadcast -vvvv

mintNFT-anvil:
	@forge script script/Interactions.s.sol:MintBasicNFT --rpc-url $(ANVIL_RPC_URL) --account defaultAnvilWallet --broadcast -vvvv

mintNFT-sepolia:
	@forge script script/Interactions.s.sol:MintBasicNFT --rpc-url $(SEPOLIA_RPC_URL) --account SepoliaDummyAccountKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv