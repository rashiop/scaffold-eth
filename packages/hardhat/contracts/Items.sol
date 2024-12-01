// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract Items is ERC1155, ERC1155Pausable, ERC1155Burnable, Ownable {
  address private _forgeryAddress;

  uint256 constant public PUPU_WHISKER = 0;
  uint256 constant public DRAGON_CLAW = 1;
  uint256 constant public MERMAID_TEAR = 2;
  uint256 constant public LUCKY_PENDANT = 3; // 0, 1
  uint256 constant public CHAOTIC_SWORD = 4; // 1, 2
  uint256 constant public MYSTERIOUS_CHARM = 5; // 0, 2
  uint256 constant public CONFUSION_BLADE = 6; // 0, 1, 2 
  
  error InvalidMintId(uint256 id);
  error Unauthorized();


  // TODO: update use IPFS uri
  constructor()
    ERC1155("https://game.example/api/item/{id}.json") Ownable(msg.sender)
  {
  }

  function setForgeryAddress(address forgeryAddress) external onlyOwner {
    _forgeryAddress = forgeryAddress;
  }

  function mintMaterial(uint256 materialId)
    external
    whenNotPaused
  {
    require(materialId >= 0 && materialId < 3, InvalidMintId(materialId));

    _mint(msg.sender, materialId, 1, "");
    _pause();
  }

  function mintItem(address to, uint256 materialId)
    external
    onlyOwner
  {
    require(msg.sender == _forgeryAddress, Unauthorized());
    require(materialId >= 3 && materialId <= 6, InvalidMintId(materialId));

    _mint(to, materialId, 1, "");
  }

  function unpause() external onlyOwner whenPaused {
    _unpause();
  }


  function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
  internal override(ERC1155, ERC1155Pausable) {
    super._update(from, to, ids, values);
  }

}