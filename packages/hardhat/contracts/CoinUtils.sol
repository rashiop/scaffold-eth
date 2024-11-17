// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

library CoinUtils {
    string public constant TOKEN_NAME = "PUPU COIN";
    string public constant TOKEN_SYMBOL = "PUPU";
    uint256 public constant TOKEN_UNIT = 1_000;
    uint256 public constant CONVERT_ETH_TO_WEI = 10 ** 18;
    uint256 public constant SELLBACK_TOKEN_TO_WEI= 1;
    uint256 public constant WEI_NEEDED_TO_MINT = 2;
    uint8 public constant DECIMALS = 18;

    function mintToken(uint256 amountWei)
        internal pure
        returns(uint256 token, uint256 excessWei)
    {
        if (amountWei < WEI_NEEDED_TO_MINT) {
            return (0, amountWei);
        } else {
            excessWei = amountWei % WEI_NEEDED_TO_MINT;
            uint256 usedWei = amountWei - excessWei;
            token = weiToTokens(usedWei);
        }
    }

    function weiToTokens(uint256 amountWei)
        internal pure
        returns(uint256 token)
    {
        token = (amountWei / WEI_NEEDED_TO_MINT) * TOKEN_UNIT;
    }

    function tokensToWei(uint256 amountToken)
        internal pure
        returns(uint256 amountWei)
    {
        amountWei = (amountToken * SELLBACK_TOKEN_TO_WEI) / TOKEN_UNIT;
    }

    function ethsToWei(uint256 amountEth)
        internal pure
        returns(uint256 amountWei)
    {
        amountWei = amountEth * CONVERT_ETH_TO_WEI;
    }
}

