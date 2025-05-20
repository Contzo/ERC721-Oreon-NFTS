-include .env

.PHONY: all test deploy

build :; forge build 

test :; forge test 

install :; forge install foundry-rs/forge-std --no-commit && forge install OpenZeppelin/openzeppelin-contracts --no-commit && forge install Cyfrin/foundry-devops --no-commit


deploy-sepolia-BasicNFT:
	@forge script script/BasicNFT/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url $(SEPOLIA_RPC_URL) --account SepoliaDummyAccountKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-anvil-BasicNFT:
	@forge script script/BasicNFT/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url $(ANVIL_RPC_URL) --account defaultAnvilWallet --broadcast -vvvv

mintNFT-anvil-BasicNFT:
	@forge script script/BasicNFT/Interactions.s.sol:MintBasicNFT --rpc-url $(ANVIL_RPC_URL) --account defaultAnvilWallet --broadcast -vvvv

mintNFT-sepolia-BasicNFT:
	@forge script script/BasicNFT/Interactions.s.sol:MintBasicNFT --rpc-url $(SEPOLIA_RPC_URL) --account SepoliaDummyAccountKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-MoodNFT:
	@forge script script/MoodNFT/DeployMoodNFT.s.sol:DeployMoodNFT --rpc-url $(SEPOLIA_RPC_URL) --account SepoliaDummyAccountKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-anvil-MoodNFT:
	@forge script script/MoodNFT/DeployMoodNFT.s.sol:DeployMoodNFT --rpc-url $(ANVIL_RPC_URL) --account defaultAnvilWallet --broadcast -vvvv

mint-anvil-MoodNFT:
	@forge script script/MoodNFT/Interactions.s.sol:MintMoodNFT --rpc-url $(ANVIL_RPC_URL) --account defaultAnvilWallet --broadcast -vvvv

TOKEN_ID ?= 0 
flipNFTMood-anvil:
	@forge script script/MoodNFT/Interactions.s.sol:FlipNFTMood --sig "run(uint256)" $(TOKEN_ID) --rpc-url $(ANVIL_RPC_URL) --account defaultAnvilWallet --broadcast -vvvv