// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "./Items.sol";

contract Forge {
  event Forged(address indexed user, uint256 indexed itemId);
  
  error IncorrectMaterial(address user, uint256[] items, uint256[] values);
  error InsufficientMaterial(address user, uint256[] items, uint256[] values);

  Items private _item;

  constructor(address _itemAddress) {
    _item = Items(_itemAddress);
  }

  function forgeLuckyPendant(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.DRAGON_CLAW(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.burnBatch(msg.sender, items, values);
    _item.mintItem(msg.sender, _item.LUCKY_PENDANT());
    emit Forged(msg.sender, _item.LUCKY_PENDANT());
  }

  function forgeChaoticSword(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.DRAGON_CLAW() && items[1] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.burnBatch(msg.sender, items, values);
    _item.mintItem(msg.sender, _item.CHAOTIC_SWORD());
  }

  function forgeMysteriousCharm(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));


    _item.burnBatch(msg.sender, items, values);
    _item.mintItem(msg.sender, _item.MYSTERIOUS_CHARM());
  }

  function forgeConfusionBlade(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.DRAGON_CLAW() && items[2] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1 && values[2] == 1,InsufficientMaterial(msg.sender, items, values));

    _item.burnBatch(msg.sender, items, values);
    _item.mintItem(msg.sender, _item.MYSTERIOUS_CHARM());

  }
}