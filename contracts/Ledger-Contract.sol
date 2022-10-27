pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract LedgerContract {
    string public name;
    uint public contractCount = 0;

    mapping(uint => Ledger) ledger;
    struct Ledger{
        address[] Contract;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    constructor(string memory _name){
        name = _name;
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