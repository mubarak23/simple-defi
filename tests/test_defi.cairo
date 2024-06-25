use starknet::{ContractAddress, get_caller_address, get_contract_address};

use snforge_std::{declare, ContractClassTrait, start_prank, stop_prank, CheatTarget};


use simple_defi::defi::ISimpleDefiDispatcher;
use simple_defi::defi::ISimpleDefiDispatcherTrait;

const USER_ONE: felt252 = 'ALICE';
const AMOUNT: u256 = 400;

fn deploy_simple_defi(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();

    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();

    contract_address

}

#[test]
fn test_deposit() {
    let contract_address = deploy_simple_defi("SimpleDefi");

    let dispatcher = ISimpleDefiDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), USER_ONE.try_into().unwrap());
    dispatcher.deposit(AMOUNT);
     // check for balance of the user USER_ONE 
     // assert(true, 'invalid pub_type');
    stop_prank(CheatTarget::One(contract_address));

}