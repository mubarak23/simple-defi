use starknet::ContractAddress;

#[starknet::interface]
pub trait IERC20<TContractState> {
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn decimal(self: @TContractState) -> u8;
    fn total_supply(self: @TContractState) -> u256;
    fn balance_of(self: @TContractState, account: ContractAdress) -> u256;
    fn allowance(self: @TContractState, owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer (ref self: @TContractState, recipient: ContractAddress, amount: u256)-> bool;
    fn transfer_from(ref self: @TContractState, sender: ContractAddress, recipiant: ContractAddress, amount: u256) -> u256;
    fn approve(ref self: @TContractState, spender: ContractAddress, amount: u256)-> bool;

}



#[starknet::interface]
pub trait ISimpleDefi<TContractState> {
    fn deposit(ref self: TContractState, amount: u256);
    fn withdraw(ref self: TContractState, shares: u256);
}

