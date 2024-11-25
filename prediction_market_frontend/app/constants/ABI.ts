export const ABI = [
    {
        "type": "impl",
        "name": "PredictionMarketImpl",
        "interface_name": "prediction_market::PredictionMarket::IPredictionMarket"
    },
    {
        "type": "enum",
        "name": "core::bool",
        "variants": [
            {
                "name": "False",
                "type": "()"
            },
            {
                "name": "True",
                "type": "()"
            }
        ]
    },
    {
        "type": "interface",
        "name": "prediction_market::PredictionMarket::IPredictionMarket",
        "items": [
            {
                "type": "function",
                "name": "create_event",
                "inputs": [
                    {
                        "name": "event_name",
                        "type": "core::felt252"
                    },
                    {
                        "name": "outcome1",
                        "type": "core::felt252"
                    },
                    {
                        "name": "outcome2",
                        "type": "core::felt252"
                    }
                ],
                "outputs": [
                    {
                        "type": "core::felt252"
                    }
                ],
                "state_mutability": "external"
            },
            {
                "type": "function",
                "name": "place_bet",
                "inputs": [
                    {
                        "name": "event_id",
                        "type": "core::felt252"
                    },
                    {
                        "name": "selected_outcome",
                        "type": "core::felt252"
                    },
                    {
                        "name": "amount",
                        "type": "core::integer::u64"
                    }
                ],
                "outputs": [
                    {
                        "type": "core::felt252"
                    }
                ],
                "state_mutability": "external"
            },
            {
                "type": "function",
                "name": "finalize_event",
                "inputs": [
                    {
                        "name": "event_id",
                        "type": "core::felt252"
                    },
                    {
                        "name": "winning_outcome",
                        "type": "core::felt252"
                    }
                ],
                "outputs": [],
                "state_mutability": "external"
            },
            {
                "type": "function",
                "name": "claim_reward",
                "inputs": [
                    {
                        "name": "bet_id",
                        "type": "core::felt252"
                    }
                ],
                "outputs": [
                    {
                        "type": "core::bool"
                    }
                ],
                "state_mutability": "external"
            }
        ]
    },
    {
        "type": "constructor",
        "name": "constructor",
        "inputs": []
    },
    {
        "type": "event",
        "name": "prediction_market::PredictionMarket::PredictionMarket::EventCreated",
        "kind": "struct",
        "members": [
            {
                "name": "event_id",
                "type": "core::felt252",
                "kind": "data"
            },
            {
                "name": "outcome1",
                "type": "core::felt252",
                "kind": "data"
            },
            {
                "name": "outcome2",
                "type": "core::felt252",
                "kind": "data"
            }
        ]
    },
    {
        "type": "event",
        "name": "prediction_market::PredictionMarket::PredictionMarket::BetPlaced",
        "kind": "struct",
        "members": [
            {
                "name": "bet_id",
                "type": "core::felt252",
                "kind": "data"
            },
            {
                "name": "event_id",
                "type": "core::felt252",
                "kind": "data"
            },
            {
                "name": "bettor",
                "type": "core::starknet::contract_address::ContractAddress",
                "kind": "data"
            },
            {
                "name": "selected_outcome",
                "type": "core::felt252",
                "kind": "data"
            },
            {
                "name": "amount",
                "type": "core::integer::u64",
                "kind": "data"
            }
        ]
    },
    {
        "type": "event",
        "name": "prediction_market::PredictionMarket::PredictionMarket::EventFinalized",
        "kind": "struct",
        "members": [
            {
                "name": "event_id",
                "type": "core::felt252",
                "kind": "data"
            },
            {
                "name": "winning_outcome",
                "type": "core::felt252",
                "kind": "data"
            }
        ]
    },
    {
        "type": "event",
        "name": "prediction_market::PredictionMarket::PredictionMarket::RewardClaimed",
        "kind": "struct",
        "members": [
            {
                "name": "bet_id",
                "type": "core::felt252",
                "kind": "data"
            },
            {
                "name": "bettor",
                "type": "core::starknet::contract_address::ContractAddress",
                "kind": "data"
            },
            {
                "name": "amount",
                "type": "core::integer::u64",
                "kind": "data"
            }
        ]
    },
    {
        "type": "event",
        "name": "prediction_market::PredictionMarket::PredictionMarket::Event",
        "kind": "enum",
        "variants": [
            {
                "name": "EventCreated",
                "type": "prediction_market::PredictionMarket::PredictionMarket::EventCreated",
                "kind": "nested"
            },
            {
                "name": "BetPlaced",
                "type": "prediction_market::PredictionMarket::PredictionMarket::BetPlaced",
                "kind": "nested"
            },
            {
                "name": "EventFinalized",
                "type": "prediction_market::PredictionMarket::PredictionMarket::EventFinalized",
                "kind": "nested"
            },
            {
                "name": "RewardClaimed",
                "type": "prediction_market::PredictionMarket::PredictionMarket::RewardClaimed",
                "kind": "nested"
            }
        ]
    }
] as const
