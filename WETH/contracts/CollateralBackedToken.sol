pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CBT is ERC20{
    IERC20 collateral;
    uint price = 1;
    
    constructor(address _collateral) ERC20("CollateralBackedToken", "CBT"){
        collateral = IERC20(_collateral);
    }
    
    function deposit(uint amount) external{
        _mint(msg.sender, price*amount);
        collateral.transferFrom(msg.sender, address(this), amount);
    }
    
    function withdraw(uint amount) external{
        require(balanceOf(msg.sender) >= amount);
        _burn(msg.sender, amount);
        collateral.transfer(msg.sender, amount*price);
    }
}