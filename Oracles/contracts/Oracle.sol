// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract Oracle{
    struct Data{
        uint date;
        uint price;
    }
    
    mapping(address => bool) reporters;
    mapping(bytes32 => Data) private data;
    address public admin;
    
    constructor (){
        admin = msg.sender;
    }
    
    function record(bytes32 key, uint payload) public{
        require(reporters[msg.sender], "Oracle: only reporters can record");
        data[key] = Data(block.timestamp, payload);
    }
    
    function updateReporter(address reporter, bool isReporter) public{
        reporters[reporter] = isReporter;
    }
    
    function getData(bytes32 key) public view returns(bool recorded, uint _date, uint _price){
        Data memory value = data[key];
        if (value.date == 0){
            return (false, 0, 0);
        }
        return (true, value.date, value.price);
    }
}