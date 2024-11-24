
#[starknet::interface]
pub trait IPredictionMarket<TContractState> {
    fn create_event(ref self: TContractState, event_name: felt252, outcome1: felt252, outcome2: felt252) -> felt252;
    fn place_bet(ref self: TContractState, event_id: felt252, selected_outcome: felt252, amount: u64) -> felt252;
    fn finalize_event(ref self: TContractState, event_id: felt252, winning_outcome: felt252);
    fn claim_reward(ref self: TContractState, bet_id: felt252) -> bool;
    fn get_event(ref self : TContractState, event_id : felt252)->(felt252, felt252, bool, felt252);
}

#[starknet::contract]
mod PredictionMarket {
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::storage::{
        StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map,Vec,
        MutableVecTrait
    };
    use core::poseidon::PoseidonTrait;
    use core::hash::{HashStateTrait, HashStateExTrait};

    #[storage]
    struct Storage {
        events: Map<felt252, (felt252, felt252, bool, felt252)>,  // event_id -> (outcome1, outcome2, is_finalized, winning_outcome)
        bets: Map<felt252, (ContractAddress, felt252, u64)>,      // bet_id -> (bettor, selected_outcome, amount)
        event_bets: Map<felt252, Vec<felt252>>,                   // event_id -> list of bet_ids
        event_count: felt252,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        EventCreated: EventCreated,
        BetPlaced: BetPlaced,
        EventFinalized: EventFinalized,
        RewardClaimed: RewardClaimed,
    }

    #[derive(Drop, starknet::Event)]
    struct EventCreated {
        event_id: felt252,
        outcome1: felt252,
        outcome2: felt252,
    }

    #[derive(Drop, starknet::Event)]
    struct BetPlaced {
        bet_id: felt252,
        event_id: felt252,
        bettor: ContractAddress,
        selected_outcome: felt252,
        amount: u64,
    }

    #[derive(Drop, starknet::Event)]
    struct EventFinalized {
        event_id: felt252,
        winning_outcome: felt252,
    }

    #[derive(Drop, starknet::Event)]
    struct RewardClaimed {
        bet_id: felt252,
        bettor: ContractAddress,
        amount: u64,
    }

    #[derive(Drop, Hash)]
    struct StructForBetHash{
        event_id : felt252,
        bettor : ContractAddress
    }

    #[derive(Drop, Hash)]
    struct StructForEventHash{
        bet_Id : felt252,
        bettor : ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
    }

    #[abi(embed_v0)]
    impl PredictionMarketImpl of super::IPredictionMarket<ContractState> {
        fn create_event(ref self: ContractState, event_name: felt252, outcome1: felt252, outcome2: felt252) -> felt252 {
            let event_id = self.event_count.read() + 1;
            self.events.entry(event_id).write((outcome1, outcome2, false, 0));
            self.event_count.write(event_id);
            self.emit(EventCreated { event_id, outcome1, outcome2 });
            event_id
        }

        fn place_bet(ref self: ContractState, event_id: felt252, selected_outcome: felt252, amount: u64) -> felt252 {
            let bettor = get_caller_address();
            let struct_to_hash = StructForBetHash {event_id : event_id, bettor : bettor };
            let bet_id = PoseidonTrait::new().update_with(struct_to_hash).finalize();
            self.bets.entry(bet_id).write((bettor, selected_outcome, amount));
            self.event_bets.entry(event_id).append().write(bet_id);
            self.emit(BetPlaced { bet_id, event_id, bettor, selected_outcome, amount });
            bet_id
        }

        fn finalize_event(ref self: ContractState, event_id: felt252, winning_outcome: felt252) {
            let (outcome1, outcome2, is_finalized, _) = self.events.entry(event_id).read();

            // Ensure event is not already finalized and the winning outcome is valid
            assert(is_finalized == false, 'Event already finalized');
            assert(winning_outcome == outcome1 || winning_outcome == outcome2, 'Invalid outcome');

            self.events.entry(event_id).write((outcome1, outcome2, true, winning_outcome));
            self.emit(EventFinalized { event_id, winning_outcome });
        }

        fn get_event(ref self : ContractState, event_id : felt252)->(felt252, felt252, bool, felt252){

        }

        fn claim_reward(ref self: ContractState, bet_id: felt252) -> bool {
            let (bettor, selected_outcome, amount) = self.bets.entry(bet_id).read();
            let struct_to_hash = StructForEventHash {bet_Id : bet_id, bettor : bettor };
            let event_id = PoseidonTrait::new().update_with(struct_to_hash).finalize();
            let (_, _, is_finalized, winning_outcome) = self.events.entry(event_id).read();

            // Ensure the event is finalized and the selected outcome matches the winning outcome
            assert(is_finalized == true, 'Event not finalized');
            assert(selected_outcome == winning_outcome, 'Incorrect outcome');

            // Reward payout logic (to be implemented as per your token model)
            self.emit(RewardClaimed { bet_id, bettor, amount });
            true
        }
    }
}
