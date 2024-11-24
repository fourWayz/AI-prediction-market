use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

use prediction_market::PredictionMarket::IPredictionMarketSafeDispatcher;
use prediction_market::PredictionMarket::IPredictionMarketSafeDispatcherTrait;
use prediction_market::PredictionMarket::IPredictionMarketDispatcher;
use prediction_market::PredictionMarket::IPredictionMarketDispatcherTrait;

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

#[test]

// create event
fn create_event(){
    let contract_address = deploy_contract("PredictionMarket");
    let contract_dispatcher = IPredictionMarketDispatcher { contract_address};
    let event_id = contract_dispatcher.create_event('first event',1,2);

    assert(event_id == 1, 'error creating event');
    // println!("event id : {:?}",event);
}


