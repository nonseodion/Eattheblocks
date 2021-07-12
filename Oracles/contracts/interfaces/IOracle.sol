// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

interface IOracle{
    
    function getData(bytes32 key) 
        external 
        view 
        returns(bool recorded, uint _date, uint _price);
}