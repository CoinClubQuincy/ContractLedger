pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract LedgerContract is ERC1155{
    string public name;
    bool public status;
    uint public contractCount = 0;
    uint keyToken;

    mapping(uint => Ledger) ledger;
    struct Ledger{
        address[] Contract;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    constructor(string memory _name,bool _contractStatus,uint _totalKeys,uint keyID,string memory _URI)ERC1155(_URI){
        name = _name;
        status = _contractStatus;
        keyToken = keyID;
        //create Ledger editor key
        _mint(msg.sender,keyToken, _totalKeys, "");
    }
    //check to 
    modifier checkPermissions(){
            checkContractStatus();   
        _;
    }
    //Checks to see if contract is owned by a token or its self
    function checkContractStatus()internal returns(bool){
        if(status == false){
            require(balanceOf(msg.sender,keyToken) > 0);
        } else {
            require(msg.sender == address(this), "only the contract can add to the ledger");
        }
    }
    //Public function to Add a new contract to the ledger
    function addContract(address[] memory _contract)public checkPermissions returns(uint){
        return _addContract(_contract);
    }   
    //Internal function to add to the ldeger based on additional code
    function _addContract(address[] memory _contract)internal returns(uint){
        ledger[contractCount] = Ledger(_contract,block.timestamp,contractCount,true);
        contractCount++;
    }  
    //View leder by ID#
    function viewLedgerID(uint _ID)public view returns(address[] memory,uint,uint,bool){
        return (ledger[_ID].Contract,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}