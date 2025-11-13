# IronLink DApp - Mobile Wallet

> 📱 Non-custodial cryptocurrency wallet for iOS and Android

---

## 🌐 Iron Blockchain Wallet Ecosystem

| # | Project | Description | Repository |
|---|---------|-------------|------------|
| 1️⃣ | **IronCore** | 🎯 钱包后端 - Backend API Server | [→ Visit](https://github.com/wejfiowej124234/IronCore) |
| 2️⃣ | **IronForge** | 🌐 前端钱包 - Web Wallet | [→ Visit](https://github.com/wejfiowej124234/IronForge) |
| 3️⃣ | **IronLink-DApp** | 📱 移动端 - Mobile DApp Wallet | 👉 **[You are here]** |
| 4️⃣ | **IronGuard-AI** | 🤖 AI安全 - AI Security Layer | [→ Visit](https://github.com/wejfiowej124234/ironguard-ai) |
| 5️⃣ | **IronVault-XR** | 🥽 智能眼镜 - AR/VR Wallet | [→ Visit](https://github.com/wejfiowej124234/IronVault-XR) |
| 6️⃣ | **Attack-Defense** | ⚔️ 攻防知识库 - Security Knowledge Base | [→ Visit](https://github.com/wejfiowej124234/Attack-Defense) |

---

## 🏆 核心特性

<div align="center">

| 🦀 Rust 全栈 | 🔓 非托管架构 | 🏢 企业级 API |
|:----------:|:------------:|:------------:|
| **100% Rust** 移动端+后端 | 私钥存储在 TEE | IronCore 46+ 端点 |
| Dioxus 原生性能 | Secure Enclave 隔离 | 99.9% SLA 保证 |
| 一次编写双平台部署 | 生物识别保护 | 实时监控 + 审计 |

</div>

---

## Overview

IronLink is a **100% Rust-powered, non-custodial** mobile wallet for iOS and Android. Built with Dioxus and enterprise-grade IronCore API, it provides hardware-isolated security with biometric authentication.

### Why IronLink?

- 🦀 **Full-Stack Rust**: Mobile (Dioxus) + Backend (IronCore), 95%+ code reuse
- 🔓 **Non-Custodial**: Keys in Secure Enclave/TEE, never uploaded to servers
- 🏢 **Enterprise Backend**: Multi-chain API, high availability, real-time monitoring

## Features

- **Multi-Chain Support**: 
  - Currently: Ethereum, BSC, Polygon, Bitcoin ✅
  - Coming: Solana (~1 week), Cosmos (~3 days) 🔥
- **Non-Custodial**: Private keys stored locally on device
- **Hardware Security**: Integration with Secure Enclave (iOS) and TEE (Android)
- **Biometric Authentication**: Face ID, Touch ID, Fingerprint support
- **Transaction Management**: Send, receive, and track transactions
- **Asset Overview**: View balances and transaction history
- **DApp Browser**: Access decentralized applications
- **Push Notifications**: Real-time transaction alerts
- **Offline Mode**: Queue transactions when offline

## Architecture

This mobile application connects to IronCore backend API for blockchain interactions:

- **Frontend**: Rust + Dioxus (cross-platform mobile framework)
- **Backend**: [IronCore](https://github.com/wejfiowej124234/IronCore)
- **Security**: Hardware-isolated key storage with biometric authentication
- **AI Protection**: [IronGuard-AI](https://github.com/wejfiowej124234/ironguard-ai) integration

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
git clone https://github.com/wejfiowej124234/IronLink-DApp.git
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
- Real-time threat detection with [IronGuard-AI](https://github.com/wejfiowej124234/ironguard-ai)
- Protected against [77+ attack types](https://github.com/wejfiowej124234/Attack-Defense)

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

## License

MIT License - see [LICENSE](LICENSE) for details

## Contributing

Contributions welcome. Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Contact

- GitHub Issues: [Report bugs or request features](https://github.com/wejfiowej124234/IronLink-DApp/issues)
- Repository: https://github.com/wejfiowej124234/IronLink-DApp

## Disclaimer

This software is provided "as is" without warranty. Users are responsible for securing their private keys and mnemonics. Use at your own risk.

## Status

Currently in development. Expected release: Q1 2026.

---

**Built with ❤️ using Rust + Dioxus**
