use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};
use prediction_market::PredictionMarket::IPredictionMarketDispatcher;
use prediction_market::PredictionMarket::IPredictionMarketDispatcherTrait;

#[derive(Drop, Hash)]
struct StructForBetHash{
    event_id : felt252,
    bettor : ContractAddress
}

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

#[test]
fn create_event(){
    let contract_address = deploy_contract("PredictionMarket");
    let contract_dispatcher = IPredictionMarketDispatcher { contract_address};
    let event_id = contract_dispatcher.create_event('first event',1,2);

    assert(event_id == 1, 'error creating event');
    
    let event_details = contract_dispatcher.get_event(event_id); 
    println!("event details : {:?}", event_details);
}

#[test]
fn place_bet(){
    let contract_address = deploy_contract("PredictionMarket");
    let contract_dispatcher = IPredictionMarketDispatcher { contract_address};
    contract_dispatcher.create_event('first event',1,2);

    let betId = contract_dispatcher.place_bet(1,1,10);
    println!("bet id : {:?}", betId);
}

#[test]
fn finalize_event(){
    let contract_address = deploy_contract("PredictionMarket");
    let contract_dispatcher = IPredictionMarketDispatcher { contract_address};
    let event_id = contract_dispatcher.create_event('first event',1,2);

    contract_dispatcher.finalize_event(event_id,1);
    let (outcome1, outcome2, is_finalized, winning_outcome) = contract_dispatcher.get_event(event_id); 

    assert(is_finalized == true, 'event not finalized');
    assert(winning_outcome == 1, 'event not finalized');
    // println!("event details : {:?}", event_details);
}
