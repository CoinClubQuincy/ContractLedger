pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract LedgerContract{
    string name;
    uint totalIDs;

struct Ledger{
    address[] _contract;
    uint _timeStamp;
    uint _id;
}

    constructor(bool _contractStatus, string memory _name){
        name = _name;
        checkContractStatus(_contractStatus);   
    }
    //Checks to see if contract is owned by a token or its self
    function checkContractStatus(bool _ContractStatus)internal returns(bool){}
    //Add a new contract to the ledger
    function addContract(address _contract)public view returns(uint){}   
    //View leder by ID#
    function viewLedgerID(uint _ID)public view returns(address[] memory,uint,uint){} 
    //check if contract exist by ID#  
    function viewLedgerExist(address _contract)public view returns(bool){}   
}