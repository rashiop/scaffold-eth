// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./Items.sol";

contract Forge is ERC1155Holder, Ownable {
  event Forged(address indexed user, uint256 indexed itemId);
  event Traded(address indexed user, uint256 indexed itemId, uint256 indexed materialId);
  
  error IncorrectMaterial(address user, uint256[] items, uint256[] values);
  error InsufficientMaterial(address user, uint256[] items, uint256[] values);
  error InvalidTrade(address user, uint256 itemId, uint256 materialId);
  error InvalidItem(address user, uint256 itemId);
  error PausedMaterial();

  Items private _item;

  constructor() Ownable(msg.sender) {}

  function setItemAddress(address _itemAddress) external onlyOwner {
    _item = Items(_itemAddress);
  }

  function onERC1155Received(
      address,
      address,
      uint256,
      uint256,
      bytes memory
  ) public virtual override returns (bytes4) {
      return this.onERC1155Received.selector;
  }

  function onERC1155BatchReceived(
    address,
    address,
    uint256[] memory,
    uint256[] memory,
    bytes memory
  ) public virtual override returns (bytes4) {
    return this.onERC1155BatchReceived.selector;
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155Holder) returns (bool) {
    return interfaceId == type(IERC1155Receiver).interfaceId || super.supportsInterface(interfaceId);
  }

  function forgeLuckyPendant(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.DRAGON_CLAW(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, abi.encode(uint256(_item.LUCKY_PENDANT())));
    _mintOrTransferItem(msg.sender, _item.LUCKY_PENDANT());
  }

  function forgeChaoticSword(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.DRAGON_CLAW() && items[1] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, abi.encode(_item.CHAOTIC_SWORD()));
    _mintOrTransferItem(msg.sender, _item.CHAOTIC_SWORD());
  }

  function forgeMysteriousCharm(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1, InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, abi.encode(_item.MYSTERIOUS_CHARM()));
    _mintOrTransferItem(msg.sender, _item.MYSTERIOUS_CHARM());
  }

  function forgeConfusionBlade(uint256[] memory items, uint256[] memory values) external {
    require(items[0] == _item.PUPU_WHISKER() && items[1] == _item.DRAGON_CLAW() && items[2] == _item.MERMAID_TEAR(), IncorrectMaterial(msg.sender, items, values));
    require(values[0] == 1 && values[1] == 1 && values[2] == 1,InsufficientMaterial(msg.sender, items, values));

    _item.safeBatchTransferFrom(msg.sender, address(this), items, values, abi.encode(_item.CONFUSION_BLADE()));
    _mintOrTransferItem(msg.sender, _item.CONFUSION_BLADE());
  }

  function _mintOrTransferItem(address to, uint256 itemId) internal {
    require(itemId >= 3 && itemId <= 6, InvalidItem(to, itemId));
    // check whether contract has the item to trade
    // if not, mint
    // else, transfer
    if (_item.balanceOf(address(this), itemId) > 0) {
      _item.safeTransferFrom(address(this), to, itemId, 1, "");
    } else {
      _item.mintItem(msg.sender, itemId);
    }
    emit Forged(msg.sender, itemId);
  }

  function tradeItemToMaterial(uint256 itemId, uint256 materialId) external {
    require(itemId >= 3 && itemId <= 6 && materialId < 3 && materialId >= 0, InvalidTrade(msg.sender, itemId, materialId));
    require(!_item.paused(), PausedMaterial());

    // check whether contract has the material to trade
    // if not, mint
    // else, transfer
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