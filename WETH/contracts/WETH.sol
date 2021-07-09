// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract WETH is ERC20{
  constructor() ERC20("Wrapped Ether", "WETH"){}

  function deposit() payable public{
    _mint(msg.sender, msg.value);
  }

  function withdraw(uint amount) public{
    require(balanceOf(msg.sender) >= amount);
    _burn(msg.sender, amount);
    (bool status,) = msg.sender.call{value: amount}("");
    require(status);
  }

  receive() payable external{
    deposit();
  }
}