-include .env

.PHONY: all test deploy

build :; forge build 

test :; forge test 

install :; forge install foundry-rs/forge-std --no-commit && forge install OpenZeppelin/openzeppelin-contracts --no-commit