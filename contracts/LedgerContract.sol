pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT

//Address Ledger. Inherit this and decide who may call addContract
abstract contract LedgerContract {
    uint public contractCount = 0;
    event ContractsAdded(uint indexed _ID);

    mapping(uint => Ledger) ledger;
    struct Ledger{
        address[] Contract;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    //Internal function to add to the ldeger based on additional code
    function addContract(address[] memory _contract)internal returns(uint){
        require(_contract.length > 0, "no addresses were given");
        ledger[contractCount] = Ledger(_contract,block.timestamp,contractCount,true);
        emit ContractsAdded(contractCount);
        return contractCount++;
    }  
    //View leder by ID#
    function viewLedgerID(uint _ID)public view returns(address[] memory,uint,uint,bool){
        return (ledger[_ID].Contract,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}

//Token Ledger (uint). Inherit this and decide who may call addTokenInt
abstract contract LedgerContractToken {
    uint public setCount = 0;
    event TokensAdded(uint indexed _ID);

    mapping(uint => Ledger) ledger;
    struct Ledger{
        uint[] _token;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    //Internal function to add to the ldeger based on additional code
    function addTokenInt(uint[] memory _token)internal returns(uint){
        require(_token.length > 0, "no tokens were given");
        ledger[setCount] = Ledger(_token,block.timestamp,setCount,true);
        emit TokensAdded(setCount);
        return setCount++;
    }  
    //View leder by ID#
    function viewIntLedgerID(uint _ID)public view returns(uint[] memory,uint,uint,bool){
        return (ledger[_ID]._token,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}

//Address Data Ledger (String). Inherit this and decide who may call addData
abstract contract LedgerContractData {
    uint public setCount = 0;
    event DataAdded(uint indexed _ID);

    mapping(uint => Ledger) ledger;
    struct Ledger{
        string[] _data;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    //Internal function to add to the ldeger based on additional code
    function addData(string[] memory _data)internal returns(uint){
        require(_data.length > 0, "no data was given");
        ledger[setCount] = Ledger(_data,block.timestamp,setCount,true);
        emit DataAdded(setCount);
        return setCount++;
    }  
    //View leder by ID#
    function viewDataLedgerID(uint _ID)public view returns(string[] memory,uint,uint,bool){
        return (ledger[_ID]._data,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}