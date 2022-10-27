pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract LedgerContract is ERC1155{
    string public name;
    bool public status;
    uint public contractCount = 0;
    uint public ledgerKeyToken;

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
        ledgerKeyToken = keyID;
        CreateEditorToken(_totalKeys);
    }
    //check token permissions
    modifier checkPermissions(){
            checkContractStatus();   
        _;
    }
    function CreateEditorToken(uint _totalKeys)internal {
        if(status == false){
            _mint(msg.sender,ledgerKeyToken, _totalKeys, "");
        }    
    }
    //Checks to see if contract is owned by a token or its self
    function checkContractStatus()internal view {
        if(status == false){
            require(balanceOf(msg.sender,ledgerKeyToken) > 0);
        } else {
            require(1 == 0,"only the contract can add to the ledger");
        }
    }
    //Public function to Add a new contract to the ledger
    function addContract(address[] memory _contract)public checkPermissions returns(uint){
        return _addContract(_contract);
    }   
    //Internal function to add to the ldeger based on additional code
    function _addContract(address[] memory _contract)internal returns(uint){
        ledger[contractCount] = Ledger(_contract,block.timestamp,contractCount,true);
        return contractCount++;
    }  
    //View leder by ID#
    function viewLedgerID(uint _ID)public view returns(address[] memory,uint,uint,bool){
        return (ledger[_ID].Contract,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}