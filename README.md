# cTRNG dApp Demo

A demonstration decentralized application (dApp) showcasing the integration of **cosmic True Random Number Generator (cTRNG)** from SpaceComputer's orbital services through the Orbitport Oracle infrastructure.

## Overview

This project demonstrates how to build blockchain applications that leverage true randomness generated from space-based hardware. The demo includes:

- **Smart Contract**: A dice game that uses cosmic randomness for fair outcomes
- **Frontend**: A Next.js web application for user interaction
- **Oracle Integration**: Direct integration with EOFeedManager oracle contracts

## What is cTRNG?

**cTRNG (cosmic True Random Number Generator)** is a service provided by SpaceComputer that harvests true random numbers from hardware on satellites. Unlike traditional pseudo-random number generators, cTRNG provides cryptographically secure randomness sourced from cosmic radiation and other space-based phenomena.

The randomness is:

- **Truly random**: Generated from physical processes in space
- **Cryptographically secure**: Suitable for sensitive applications
- **Tamper-proof**: Signed by satellite hardware to ensure authenticity
- **High availability**: Served by multiple providers and satellites

## Architecture

### Smart Contract (`DiceGame.sol`)

The core contract implements a simple dice game where:

1. **Players place bets** by calling `bet(uint256 choice)` with their choice (1-6) and ETH
2. **Game resolution** occurs when `resolve()` is called, which:
   - Fetches the latest randomness from the EOFeedManager oracle
   - Converts the oracle value to a dice roll (1-6) using modulo arithmetic
   - Sets the winning side and marks the game as resolved

```solidity
function resolve() external {
    IEOFeedManager.PriceFeed memory priceFeed = feedManager.getLatestPriceFeed(FEED_ID);
    require(priceFeed.timestamp > 0, "Oracle data not available");
    oracleValue = priceFeed.value;
    winningSide = (oracleValue % 6) + 1; // Convert to 1-6
    resolved = true;
}
```

### Oracle Integration

The contract integrates with the **EOFeedManager** oracle contract deployed at:

- **Address**: `0x5a38f4ee6e1da80b36fa94ad1d55f48a64f60572`
- **Network**: Arbitrum Sepolia
- **Feed ID**: `0` (cTRNG randomness feed)

The oracle provides:

- **Latest randomness data** via `getLatestPriceFeed()`
- **Timestamp verification** to ensure data freshness
- **Cryptographic verification** through BLS signatures and Merkle proofs

### Frontend Application

Built with modern web technologies:

- **Next.js 15**: React framework with App Router
- **RainbowKit**: Wallet connection and management
- **Wagmi**: Ethereum interaction library
- **Tailwind CSS**: Styling framework
- **TypeScript**: Type-safe development

The frontend is configured for **Arbitrum Sepolia** testnet and includes:

- Wallet connection via RainbowKit
- Contract interaction capabilities
- Responsive design

## Project Structure

```
ctrng-dapp-demo/
├── dapp/                    # Smart contract implementation
│   ├── src/
│   │   └── DiceGame.sol    # Main game contract
│   ├── script/
│   │   └── DiceGame.s.sol  # Deployment script
│   └── lib/
│       └── target-contracts/ # EOracle contracts
├── frontend/                # Web application
│   ├── src/
│   │   ├── pages/          # Next.js pages
│   │   ├── lib/            # Configuration
│   │   └── abi/            # Contract ABIs
│   └── package.json
└── README.md
```

## Getting Started

### Prerequisites

- **Node.js** (v18 or later)
- **Foundry** for smart contract development
- **Arbitrum Sepolia ETH** for testing
- **Wallet** (MetaMask recommended)

### Smart Contract Setup

1. **Install Foundry**:

   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **Navigate to dapp directory**:

   ```bash
   cd dapp
   ```

3. **Install dependencies**:

   ```bash
   forge install
   ```

4. **Build contracts**:

   ```bash
   forge build
   ```

5. **Deploy to Arbitrum Sepolia**:
   ```bash
   forge script script/DiceGame.s.sol --rpc-url <ARBITRUM_SEPOLIA_RPC> --broadcast --verify
   ```

### Frontend Setup

1. **Navigate to frontend directory**:

   ```bash
   cd frontend
   ```

2. **Install dependencies**:

   ```bash
   npm install
   ```

3. **Set environment variables**:

   ```bash
   cp .env.example .env.local
   # Add your WalletConnect Project ID
   NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=your-project-id
   ```

4. **Start development server**:

   ```bash
   npm run dev
   ```

5. **Open browser**: Navigate to `http://localhost:3000`

## Usage

### Playing the Dice Game

1. **Connect Wallet**: Use the RainbowKit connect button
2. **Switch to Arbitrum Sepolia**: Ensure you're on the correct testnet
3. **Place Bet**: Call the `bet()` function with your choice (1-6) and ETH
4. **Resolve Game**: Call `resolve()` to determine the winning number using cosmic randomness
5. **Check Results**: View the winning side and oracle value

### Contract Functions

- `bet(uint256 choice)`: Place a bet with ETH (choice must be 1-6)
- `resolve()`: Resolve the game using latest oracle data
- `bets(address)`: View a player's bet details
- `winningSide`: Get the winning dice number
- `oracleValue`: Get the raw oracle value used for resolution
- `resolved`: Check if the game has been resolved

## Oracle Information

This project integrates with the **Orbitport Oracle** infrastructure. For detailed information about:

- **Contract addresses** and deployments
- **Oracle architecture** and verification
- **Integration examples** and best practices
- **Security audits** and documentation

Please refer to the [Orbitport Oracle Repository](https://github.com/spacecomputer-io/orbitport-oracle).

### Key Oracle Features

- **EOFeedManager**: Main oracle contract for feed management
- **EOFeedVerifier**: Handles BLS signature and Merkle proof verification
- **Pull-based architecture**: Applications request latest data on-demand
- **Upgradeable contracts**: Emergency pause and upgrade capabilities
- **Multi-provider support**: High availability through multiple satellite providers

## Security Considerations

- **Oracle dependency**: Game resolution depends on oracle availability
- **Single point of failure**: Currently uses one oracle feed
- **Timing attacks**: Consider implementing commit-reveal schemes for production
- **Access control**: Add proper access controls for production deployment

## Future Enhancements

- **Multi-round games**: Support for multiple game rounds
- **Prize distribution**: Automatic prize distribution to winners
- **Game history**: Track and display game history
- **Advanced randomness**: Use multiple oracle feeds for enhanced security
- **Gas optimization**: Optimize contract for lower gas costs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Resources

- **SpaceComputer Documentation**: [docs.spacecomputer.io](https://docs.spacecomputer.io/)
- **Orbitport Oracle Repository**: [github.com/spacecomputer-io/orbitport-oracle](https://github.com/spacecomputer-io/orbitport-oracle)
- **Arbitrum Sepolia Explorer**: [sepolia.arbiscan.io](https://sepolia.arbiscan.io/)
- **Foundry Documentation**: [book.getfoundry.sh](https://book.getfoundry.sh/)

---

**Built with ❤️ by the SpaceComputer team**

_Demonstrating the power of cosmic randomness in decentralized applications_
