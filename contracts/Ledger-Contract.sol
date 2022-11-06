pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT

//Address Ledger 
contract LedgerContract {
    uint public contractCount = 0;

    mapping(uint => Ledger) ledger;
    struct Ledger{
        address[] Contract;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    //Internal function to add to the ldeger based on additional code
    function addContract(address[] memory _contract)internal returns(uint){
        ledger[contractCount] = Ledger(_contract,block.timestamp,contractCount,true);
        return contractCount++;
    }  
    //View leder by ID#
    function viewLedgerID(uint _ID)public view returns(address[] memory,uint,uint,bool){
        return (ledger[_ID].Contract,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}

//Token Ledger (uint)
contract LedgerContractInt {
    uint public contractCount = 0;

    mapping(uint => Ledger) ledger;
    struct Ledger{
        uint[] _token;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    //Internal function to add to the ldeger based on additional code
    function addTokenInt(uint[] memory _token)internal returns(uint){
        ledger[contractCount] = Ledger(_token,block.timestamp,contractCount,true);
        return contractCount++;
    }  
    //View leder by ID#
    function viewIntLedgerID(uint _ID)public view returns(uint[] memory,uint,uint,bool){
        return (ledger[_ID]._token,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}

//Address Data Ledger (String)
contract LedgerContractData {
    uint public contractCount = 0;

    mapping(uint => Ledger) ledger;
    struct Ledger{
        string[] _data;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    //Internal function to add to the ldeger based on additional code
    function addData(string[] memory _data)internal returns(uint){
        ledger[contractCount] = Ledger(_data,block.timestamp,contractCount,true);
        return contractCount++;
    }  
    //View leder by ID#
    function viewDataLedgerID(uint _ID)public view returns(string[] memory,uint,uint,bool){
        return (ledger[_ID]._data,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}