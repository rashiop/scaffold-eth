/**
 * This file is autogenerated by Scaffold-ETH.
 * You should not edit it manually or your changes might be overwritten.
 */
import { GenericContractsDeclaration } from "~~/utils/scaffold-eth/contract";

const deployedContracts = {
  31337: {
    PupuCoin: {
      address: "0x5FbDB2315678afecb367f032d93F642f64180aa3",
      abi: [
        {
          inputs: [],
          stateMutability: "nonpayable",
          type: "constructor",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "spender",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "allowance",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "needed",
              type: "uint256",
            },
          ],
          name: "ERC20InsufficientAllowance",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "sender",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "balance",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "needed",
              type: "uint256",
            },
          ],
          name: "ERC20InsufficientBalance",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "approver",
              type: "address",
            },
          ],
          name: "ERC20InvalidApprover",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "receiver",
              type: "address",
            },
          ],
          name: "ERC20InvalidReceiver",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "sender",
              type: "address",
            },
          ],
          name: "ERC20InvalidSender",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "spender",
              type: "address",
            },
          ],
          name: "ERC20InvalidSpender",
          type: "error",
        },
        {
          inputs: [],
          name: "EmptyAmount",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "amount",
              type: "uint256",
            },
          ],
          name: "FailedToSendWei",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "amount",
              type: "uint256",
            },
          ],
          name: "FailedToWithdraw",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "tokenAvailable",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "tokenRequired",
              type: "uint256",
            },
          ],
          name: "InsufficientToken",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "tokenAvailable",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "tokenRequired",
              type: "uint256",
            },
          ],
          name: "InsufficientTokenSupply",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "weiAvailable",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "weiRequired",
              type: "uint256",
            },
          ],
          name: "InsufficientWeiSupply",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "weiAvailable",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "weiRequired",
              type: "uint256",
            },
          ],
          name: "InsufficientWeiToMint",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
          ],
          name: "InvalidAddress",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "owner",
              type: "address",
            },
          ],
          name: "OwnableInvalidOwner",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "account",
              type: "address",
            },
          ],
          name: "OwnableUnauthorizedAccount",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
          ],
          name: "UserBlacklisted",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "user",
              type: "address",
            },
          ],
          name: "UserNotWhitelisted",
          type: "error",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "owner",
              type: "address",
            },
            {
              indexed: true,
              internalType: "address",
              name: "spender",
              type: "address",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "value",
              type: "uint256",
            },
          ],
          name: "Approval",
          type: "event",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              indexed: false,
              internalType: "bool",
              name: "blacklisted",
              type: "bool",
            },
          ],
          name: "Blacklist",
          type: "event",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "previousOwner",
              type: "address",
            },
            {
              indexed: true,
              internalType: "address",
              name: "newOwner",
              type: "address",
            },
          ],
          name: "OwnershipTransferred",
          type: "event",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "weiAmount",
              type: "uint256",
            },
          ],
          name: "Refund",
          type: "event",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "from",
              type: "address",
            },
            {
              indexed: true,
              internalType: "address",
              name: "to",
              type: "address",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "value",
              type: "uint256",
            },
          ],
          name: "Transfer",
          type: "event",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              indexed: false,
              internalType: "bool",
              name: "whitelist",
              type: "bool",
            },
          ],
          name: "UpdateWhitelist",
          type: "event",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "tokenAmount",
              type: "uint256",
            },
          ],
          name: "Withdraw",
          type: "event",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "owner",
              type: "address",
            },
            {
              internalType: "address",
              name: "spender",
              type: "address",
            },
          ],
          name: "allowance",
          outputs: [
            {
              internalType: "uint256",
              name: "",
              type: "uint256",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "spender",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "value",
              type: "uint256",
            },
          ],
          name: "approve",
          outputs: [
            {
              internalType: "bool",
              name: "",
              type: "bool",
            },
          ],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "account",
              type: "address",
            },
          ],
          name: "balanceOf",
          outputs: [
            {
              internalType: "uint256",
              name: "",
              type: "uint256",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              internalType: "bool",
              name: "blacklist",
              type: "bool",
            },
          ],
          name: "blackListUser",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "",
              type: "address",
            },
          ],
          name: "blacklists",
          outputs: [
            {
              internalType: "bool",
              name: "",
              type: "bool",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "uint256",
              name: "value",
              type: "uint256",
            },
          ],
          name: "burn",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "account",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "value",
              type: "uint256",
            },
          ],
          name: "burnFrom",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "amount",
              type: "uint256",
            },
          ],
          name: "changeBalanceAtAddress",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "decimals",
          outputs: [
            {
              internalType: "uint8",
              name: "",
              type: "uint8",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "amount",
              type: "uint256",
            },
          ],
          name: "mintTokenToAddress",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "name",
          outputs: [
            {
              internalType: "string",
              name: "",
              type: "string",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "owner",
          outputs: [
            {
              internalType: "address",
              name: "",
              type: "address",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "renounceOwnership",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "uint256",
              name: "tokenAmount",
              type: "uint256",
            },
          ],
          name: "sellback",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "target",
              type: "address",
            },
            {
              internalType: "bool",
              name: "whitelist",
              type: "bool",
            },
          ],
          name: "setWhitelist",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "symbol",
          outputs: [
            {
              internalType: "string",
              name: "",
              type: "string",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "tokenSale",
          outputs: [],
          stateMutability: "payable",
          type: "function",
        },
        {
          inputs: [],
          name: "totalSupply",
          outputs: [
            {
              internalType: "uint256",
              name: "",
              type: "uint256",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "to",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "value",
              type: "uint256",
            },
          ],
          name: "transfer",
          outputs: [
            {
              internalType: "bool",
              name: "",
              type: "bool",
            },
          ],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "from",
              type: "address",
            },
            {
              internalType: "address",
              name: "to",
              type: "address",
            },
            {
              internalType: "uint256",
              name: "value",
              type: "uint256",
            },
          ],
          name: "transferFrom",
          outputs: [
            {
              internalType: "bool",
              name: "",
              type: "bool",
            },
          ],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "newOwner",
              type: "address",
            },
          ],
          name: "transferOwnership",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "withdraw",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
      ],
      inheritedFunctions: {
        allowance:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        approve:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        balanceOf:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        decimals:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        name: "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        symbol:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        totalSupply:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        transfer:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        transferFrom:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        burn: "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        burnFrom:
          "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol",
        owner: "@openzeppelin/contracts/access/Ownable.sol",
        renounceOwnership: "@openzeppelin/contracts/access/Ownable.sol",
        transferOwnership: "@openzeppelin/contracts/access/Ownable.sol",
      },
    },
  },
} as const;

export default deployedContracts satisfies GenericContractsDeclaration;
