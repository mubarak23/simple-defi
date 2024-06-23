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


#[starknet::contract]
pub mod SimpleDefi {
    use super::{IERC20Dispatcher, IERC20DispatcherTrait};
    use starknet::{ContractAddress, get_caller_address, get_contract_address};

    #[storage]
    struct Storage {
        token: IERC20Dispatcher,
        total_supply: u256,
        balance_of: LegacyMap<ContractAddress, u256>
    }

    #[constructor]
    fn constructor (ref self: ContractState, token: ContractAddress) {
        self.token.write(IERC20Dispatcher { contract_address: token});
    }

    #[generate_trait]
    impl PrivateFunctions of PrivateFunctionsTrait {
        fn _mint(ref self: ContractState, to: ContractAddress, shares: u256) {
            self.total_supply.write(self.total_supply.read() + shares);
            self.balance_of.write(self.balance_of.read(to) + shares);
        }
        fn _burn(ref self: ContractState, from: ContractAddress, shares: u256) {
             self.total_supply.write(self.total_supply.read() - shares);
            self.balance_of.write(self.balance_of.read(from) - shares);
        }
    }
}