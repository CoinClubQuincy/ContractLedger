pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT

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

contract LedgerContractInt {
    uint public contractCount = 0;

    mapping(uint => Ledger) ledger;
    struct Ledger{
        uint[] _slotInt;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    //Internal function to add to the ldeger based on additional code
    function addSlotInt(uint[] memory _contract)internal returns(uint){
        ledger[contractCount] = Ledger(_contract,block.timestamp,contractCount,true);
        return contractCount++;
    }  
    //View leder by ID#
    function viewLedgerID(uint _ID)public view returns(uint[] memory,uint,uint,bool){
        return (ledger[_ID]._slotInt,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}