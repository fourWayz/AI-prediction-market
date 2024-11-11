import { Provider, Contract } from "starknet";

export const provider = new Provider({ network: "mainnet-alpha" });
export const predictionMarketContract = new Contract(PredictionMarketABI, contractAddress, provider);
