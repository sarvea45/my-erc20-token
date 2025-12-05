# MyToken (MTK) - ERC-20 Implementation

## Overview
MyToken is a fully functional ERC-20 smart contract built on the Ethereum blockchain. It was developed to understand the underlying logic of cryptocurrency tokens, including state management, event logging, and the approval mechanism.

## Token Details
- **Name:** SarveshToken
- **Symbol:** MTK
- **Decimals:** 18
- **Total Supply:** 1,000,000 MTK (Fixed)
- **Standard:** ERC-20

## What are ERC-20 Tokens?
ERC-20 is the technical standard for fungible tokens on the Ethereum blockchain. It defines a common set of rules (functions and events) that allow tokens to work seamlessly with wallets (like MetaMask) and exchanges. "Fungible" means every token is identical to every other token.

## Implemented Features
1.  **Transfer:** Users can send tokens directly to other addresses.
2.  **Approve:** Owners can authorize third parties (spenders) to use their tokens.
3.  **TransferFrom:** Allows approved spenders to move tokens on behalf of the owner (essential for DeFi applications).
4.  **Events:** Emits `Transfer` and `Approval` events for transparency and off-chain tracking.
5.  **Validation:** Includes checks for zero addresses and insufficient balances.

## Deployment Instructions
1.  Open **Remix IDE** (remix.ethereum.org).
2.  Create a new file named `MyToken.sol` inside the `contracts` folder.
3.  Paste the source code.
4.  Go to the **Solidity Compiler** tab and select version `0.8.x`. Click "Compile".
5.  Go to the **Deploy & Run** tab.
6.  In the "Deploy" argument box, enter the supply with 18 zeros: `1000000000000000000000000`.
7.  Click **Deploy**.

## Usage Examples

### 1. Checking Balance
Call `balanceOf` with your address.
**Result:** Returns the total number of tokens (uint256).

### 2. Transferring Tokens
Call the `transfer` function:
- `_to`: `0xAb8...` (Recipient Address)
- `_value`: `1000000000000000000` (1 Token)

### 3. Delegated Transfer (Approve & TransferFrom)
**Step A (Owner):** Call `approve`:
- `_spender`: Address of the person/contract allowed to spend.
- `_value`: Amount they can spend.

**Step B (Spender):** Call `transferFrom`:
- `_from`: Owner's address.
- `_to`: Recipient's address.
- `_value`: Amount to transfer.

## Testing Scenarios & Results
| Scenario | Action | Result |
|----------|--------|--------|
| **Initial Mint** | Deploy contract | Total supply assigned to deployer. |
| **Standard Transfer** | Transfer 100 tokens to Address B | Balances updated correctly. |
| **Insufficient Balance** | Try to send more tokens than owned | Transaction reverts with error "Insufficient balance". |
| **Zero Address** | Try to send to 0x000... | Transaction reverts (Safety check). |
| **Allowance** | Approve Address B to spend 50 tokens | Allowance mapping updated. |

## What I Learned
Through building this project, I learned:
- **Solidity Fundamentals:** How `mapping` works to track balances and how `msg.sender` identifies the caller.
- **The Importance of Decimals:** Why we use `uint256` and 18 decimals (to handle high precision without floating-point numbers).
- **The Approval Pattern:** Understanding how `transferFrom` differs from `transfer` and why it's crucial for DApps to interact with user tokens.
- **Event Logging:** How `emit` stores data on the blockchain logs, which is how block explorers show transaction history.
