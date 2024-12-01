// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./Items.sol";

contract Forge is ERC1155Holder, Ownable {
  event Forged(address indexed user, uint256 indexed itemId);
  event Traded(address indexed user, uint256 indexed itemId, uint256 indexed materialId);
  
  error IncorrectMaterial(address user, uint256[] items, uint256[] values);
  error InsufficientMaterial(address user, uint256[] items, uint256[] values);
  error InvalidTrade(address user, uint256 itemId, uint256 materialId);
  error PausedMaterial();

  Items private _item;

  constructor() Ownable(msg.sender) {}

  function setItemAddress(address _itemAddress) external onlyOwner {
    _item = Items(_itemAddress);
  }

  function onERC1155BatchReceived(
      address,
      address,
      uint256[] memory,
      uint256[] memory,
      bytes
  ) public virtual override returns (bytes4) {
      // TODO: update transfer token here
      return this.onERC1155BatchReceived.selector;
  }

  function forgeLuckyPendant(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.DRAGON_CLAW(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, "");
    // TODO: extract this to onERC1155BatchReceived
    _item.mintItem(msg.sender, _item.CHAOTIC_SWORD());
    emit Forged(msg.sender, _item.CHAOTIC_SWORD());

  }

  function forgeChaoticSword(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.DRAGON_CLAW() && items[1] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, "1");
    // TODO: extract this to onERC1155BatchReceived
    _item.mintItem(msg.sender, _item.CHAOTIC_SWORD());
    emit Forged(msg.sender, _item.CHAOTIC_SWORD());
  }

  function forgeMysteriousCharm(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, "");
    // TODO: extract this to onERC1155BatchReceived
    _item.mintItem(msg.sender, _item.MYSTERIOUS_CHARM());
    emit Forged(msg.sender, _item.MYSTERIOUS_CHARM());

  }

  function forgeConfusionBlade(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.DRAGON_CLAW() && items[2] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1 && values[2] == 1,InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, "");
    // TODO: extract this to onERC1155BatchReceived
    _item.mintItem(msg.sender, _item.CONFUSION_BLADE());
    emit Forged(msg.sender, _item.CONFUSION_BLADE());
  }

  function tradeItemToMaterial(uint256 itemId, uint256 materialId) external {
    require(itemId >= 3 && itemId <= 6 && materialId < 3 && materialId >= 0, InvalidTrade(msg.sender, itemId, materialId));
    require(!_item.paused(), PausedMaterial());

    if (_item.balanceOf(address(this), materialId) < 1) {
      _item.safeTransferFrom(msg.sender, address(this), itemId, 1, "");
      _item.mintItem(msg.sender, materialId);
    } else {
      _item.safeTransferFrom(address(this), msg.sender, materialId, 1, "");
      _item.safeTransferFrom(msg.sender, address(this), itemId, 1, "");
    }
    emit Traded(msg.sender, itemId, materialId);
  }
}