# IronLink DApp

A non-custodial cryptocurrency wallet for iOS and Android.

## Overview

IronLink is a mobile wallet application built with Rust and Dioxus, providing secure cryptocurrency storage and transaction capabilities across multiple blockchains.

## Features

- **Multi-Chain Support**: Ethereum, Bitcoin, Solana, BSC, Polygon
- **Non-Custodial**: Private keys stored locally on device
- **Hardware Security**: Integration with Secure Enclave (iOS) and TEE (Android)
- **Biometric Authentication**: Face ID, Touch ID, Fingerprint support
- **Transaction Management**: Send, receive, and track transactions
- **Asset Overview**: View balances and transaction history
- **DApp Browser**: Access decentralized applications

## Architecture

This mobile application connects to a Rust backend API for blockchain interactions:

- **Frontend**: Rust + Dioxus (cross-platform mobile framework)
- **Backend**: [Rust-Blockchain-Secure-Wallet](https://github.com/DarkCrab-Rust/Rust-Blockchain-Secure-Wallet)
- **Security**: Hardware-isolated key storage with biometric authentication

## Supported Networks

- Ethereum (Mainnet, Sepolia)
- Bitcoin (Mainnet, Testnet)
- Solana (Mainnet, Devnet)
- BSC (Mainnet, Testnet)
- Polygon (Mainnet, Mumbai)

## Installation

### iOS
- Requirements: iOS 13.0+
- Download: Coming soon (2026 Q1)

### Android
- Requirements: Android 9.0+
- Download: Coming soon (2026 Q1)

## Development Setup

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Dioxus CLI
cargo install dioxus-cli

# Add mobile targets
rustup target add aarch64-apple-ios
rustup target add aarch64-linux-android

# Clone repository
git clone https://github.com/DarkCrab-Rust/IronLink-DApp.git
cd IronLink-DApp

# Run development build
dx serve --platform mobile
```

## Security

- Private keys never leave the device
- Hardware-isolated key storage (Secure Enclave/TEE)
- Biometric authentication required for transactions
- Local encrypted storage (AES-256-GCM)
- Open source code for community audit

## Project Structure

```
IronLink-DApp/
├── src/
│   ├── components/     # UI components
│   ├── services/       # Blockchain services
│   ├── storage/        # Secure storage
│   └── platform/       # Platform-specific code
├── Cargo.toml
└── Dioxus.toml
```

## Ecosystem

Part of the DarkCrab-Rust blockchain wallet ecosystem:

- **Backend API**: [Rust-Blockchain-Secure-Wallet](https://github.com/DarkCrab-Rust/Rust-Blockchain-Secure-Wallet)
- **Web Frontend**: [blockchain-wallet-ui](https://github.com/DarkCrab-Rust/blockchain-wallet-ui)
- **AI Security**: [IronGuard-AI](https://github.com/DarkCrab-Rust/ironguard-ai)
- **AR Wallet**: [IronVault-XR](https://github.com/DarkCrab-Rust/IronVault-XR)

## License

MIT License - see [LICENSE](LICENSE) for details

## Contributing

Contributions welcome. Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Contact

- GitHub Issues: [Report bugs or request features](https://github.com/DarkCrab-Rust/IronLink-DApp/issues)
- Repository: https://github.com/DarkCrab-Rust/IronLink-DApp

## Disclaimer

This software is provided "as is" without warranty. Users are responsible for securing their private keys and mnemonics. Use at your own risk.

## Status

Currently in development. Expected release: Q1 2026.
