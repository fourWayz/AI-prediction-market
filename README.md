```markdown
# AI Prediction Market DApp

This project is an AI-powered Prediction Market decentralized application (dApp) built on StarkNet. It allows users to create events, place bets on outcomes, and claim rewards based on event results, with predictions powered by OpenAI's language model for additional insights.

## Table of Contents
1. [Features](#features)
2. [Technology Stack](#technology-stack)
3. [Smart Contract Structure](#smart-contract-structure)
4. [Installation](#installation)
5. [Configuration](#configuration)
6. [Usage](#usage)
7. [Project Structure](#project-structure)
8. [License](#license)

---

## Features

- **Event Creation**: Users can create events with two possible outcomes.
- **Bet Placement**: Users can bet on outcomes with their desired amount.
- **Event Finalization**: Events are finalized with a winning outcome by the creator.
- **AI Predictions**: OpenAI integration provides predictive insights on event outcomes.
- **Reward Claims**: Bettors can claim rewards based on accurate predictions.

## Technology Stack

- **Cairo (StarkNet)**: For building smart contracts.
- **Next.js**: Frontend framework for UI and dApp interaction.
- **OpenAI API**: For off-chain AI-powered predictions.
- **TypeScript & JavaScript**: For frontend logic and API calls.
  
## Smart Contract Structure

The Cairo contract is organized in a Rust-inspired way for a clear, modular structure:

- **Traits**: Defines public contract interfaces.
- **Events**: Event emissions provide transparency for contract state changes.
- **Storage**: Maps store events, bets, and user information.
- **Functions**: Core functions include `create_event`, `place_bet`, `finalize_event`, and `claim_reward`.

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/fourWayz/AI-prediction-market.git
   cd ai-prediction-market
   ```

2. **Install dependencies for Next.js frontend**
   ```bash
   cd frontend && npm install
   ```

3. **Install Cairo and StarkNet dependencies** (Refer to StarkNet [official documentation](https://www.cairo-lang.org/docs/quickstart.html))

4. **Set up OpenAI API Key** (Get your key from the [OpenAI API](https://beta.openai.com/signup/)).

## Configuration

Create a `.env.local` file in the project root and add your OpenAI API key:

```plaintext
OPENAI_API_KEY=your_openai_api_key_here
```

## Usage

### 1. Compile and Deploy the Cairo Contract
Use the Cairo scarb to compile and deploy the contract on StarkNet (Testnet or Mainnet).

```

### 2. Run the Frontend

Start the Next.js development server.

```bash
npm run dev
```

The dApp will be available at [http://localhost:3000](http://localhost:3000).
