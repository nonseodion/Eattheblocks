// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./interfaces/IOracle.sol";

contract Client{
    IOracle public oracle;
    
    constructor(IOracle _oracle){
        oracle = _oracle;
    }
    
    function consume() public{
        bytes32 key = keccak256(abi.encodePacked("BTC/USD"));
        (bool recorded, uint date, uint data) = oracle.getData(key);
        require(recorded, "Client: Price not recorded");
        require(date >= block.timestamp - 2 minutes, "Client: Price too old");
        //do something with price
    }
}