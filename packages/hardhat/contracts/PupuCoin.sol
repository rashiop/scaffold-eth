//SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "hardhat/console.sol";


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CoinUtils.sol";

// owned by admin
contract PupuCoin is ERC20, ERC20Burnable, Ownable {
    mapping(address => bool) public blacklists;
    mapping(address => bool) private _whitelists;

    event UpdateWhitelist(address indexed target, bool whitelist);
    
    event Blacklist(address indexed target, bool blacklisted);
    event Refund(address indexed target, uint256 weiAmount);
    event Withdraw(address indexed target, uint256 tokenAmount);

    error EmptyAmount();
    error FailedToSendWei(address user, uint256 amount);
    error FailedToWithdraw(address user, uint256 amount);
    error InsufficientWeiToMint(address user, uint256 weiAvailable, uint256 weiRequired);
    error InvalidAddress(address user);
    error InsufficientToken(address user, uint256 tokenAvailable, uint256 tokenRequired);
    error InsufficientWeiSupply(address user, uint256 weiAvailable, uint256 weiRequired);
    error InsufficientTokenSupply(address user, uint256 tokenAvailable, uint256 tokenRequired);
    error UserBlacklisted(address user);
    error UserNotWhitelisted(address user);

    modifier notBlacklisted(address user) {
        require(!blacklists[user], UserBlacklisted(user));
        _;
    }

    modifier isWhitelist(address user) {
        require(_whitelists[user] == true, UserNotWhitelisted(user));
        _;
    }

    modifier validAddress(address target) {
        require(target != address(0), InvalidAddress(target));
        _;
    }

    constructor()
        ERC20(CoinUtils.TOKEN_NAME, CoinUtils.TOKEN_SYMBOL)
        Ownable(msg.sender)
    {
        setWhitelist(msg.sender, true);
    }

    function decimals() public view virtual override returns (uint8) {
        return CoinUtils.DECIMALS;
    }

    function mintTokenToAddress(address target, uint256 amount)
        isWhitelist(msg.sender) validAddress(target)
        external
    {
        require(amount > 0, EmptyAmount());
        _mint(target, amount);
    }

    function changeBalanceAtAddress(address target, uint256 amount)
        isWhitelist(msg.sender)
        validAddress(target)
        external
    {
        uint256 balance = balanceOf(target);

        unchecked {
            if (amount > balance) {
                _mint(target, amount - balance);
            } else if (amount < balance) {
                _burn(target, balance - amount);
            }
        }
    }

    function blackListUser(address target, bool blacklist)
        onlyOwner
        validAddress(target)
        external
    {
        if (blacklists[target] != blacklist) {
            blacklists[target] = blacklist;
            emit Blacklist(target, blacklist);
        }
    }

    function setWhitelist(address target, bool whitelist)
        onlyOwner
        validAddress(target)
        public
    {
        if (_whitelists[target] != whitelist) {
            _whitelists[target] = whitelist;
            emit UpdateWhitelist(target, whitelist);
        }
    }

    function tokenSale()
        notBlacklisted(msg.sender)
        external
        payable
    {
        (uint256 tokenToMint, uint256 excessWei) = CoinUtils.mintToken(msg.value);
        require(tokenToMint > 0,
            InsufficientWeiToMint({
                user: msg.sender,
                weiAvailable: msg.value,
                weiRequired: CoinUtils.WEI_NEEDED_TO_MINT
            })
        );

        _mint(msg.sender, tokenToMint);

        if (excessWei > 0) {
            _refund(msg.sender, excessWei);
        }
    }

    function _refund(address target, uint256 weiAmount) private {
        _sendWei(target, weiAmount);
        emit Refund(target, weiAmount);
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, FailedToWithdraw({user: msg.sender, amount: balance}));
        _sendWei(msg.sender, balance);
        emit Withdraw(msg.sender, balance);
    }

    function _sendWei(address target, uint256 amount) private validAddress(target) {
        require(amount > 0, EmptyAmount());
        (bool success, ) = target.call{value: amount}("");
        require(success, FailedToSendWei({user: target, amount: amount}));
    }

    function sellback(uint256 tokenAmount) external notBlacklisted(msg.sender) {
        uint256 userBalance = balanceOf(msg.sender);
        require(userBalance >= tokenAmount,
            InsufficientToken({
                user: msg.sender,
                tokenRequired: tokenAmount,
                tokenAvailable: userBalance
            })
        );

        uint256 weiRequired = CoinUtils.tokensToWei(tokenAmount);
        uint256 contractBalance = address(this).balance;
        uint256 weiBalance = CoinUtils.ethsToWei(contractBalance);
        require(
            weiBalance >= weiRequired,
            InsufficientWeiSupply({
                weiRequired: weiRequired,
                weiAvailable: weiBalance,
                user: msg.sender
            })
        );

        _burn(msg.sender, tokenAmount);
        _refund(msg.sender, weiRequired);
    }
}
