pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract LedgerContract is ERC1155{
    string public name;
    uint public contractCount = 0;
    uint public ledgerKeyToken;

    mapping(uint => Ledger) ledger;
    struct Ledger{
        address[] Contract;
        uint TimeStamp;
        uint ID;
        bool Exist;
    }
    constructor(string memory _name,uint _totalKeys,uint keyID,string memory _URI)ERC1155(_URI){
        name = _name;
        ledgerKeyToken = keyID;
        _mint(msg.sender,ledgerKeyToken, _totalKeys, "");
    }
    //check token permissions
    modifier checkPermissions(){
            require(balanceOf(msg.sender,ledgerKeyToken) > 0);
        _;
    }
    //Internal function to add to the ldeger based on additional code
    function addContract(address[] memory _contract)public checkPermissions returns(uint){
        ledger[contractCount] = Ledger(_contract,block.timestamp,contractCount,true);
        return contractCount++;
    }  
    //View leder by ID#
    function viewLedgerID(uint _ID)public view returns(address[] memory,uint,uint,bool){
        return (ledger[_ID].Contract,ledger[_ID].TimeStamp,ledger[_ID].ID,ledger[_ID].Exist);
    } 
}