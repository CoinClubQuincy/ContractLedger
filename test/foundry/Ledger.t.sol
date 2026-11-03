// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../../contracts/LedgerContract.sol";
import "../../contracts/LedgerUser.sol";

contract Addresses is LedgerContract {
    function add(address[] memory a) external returns (uint) { return addContract(a); }
}

contract Tokens is LedgerContractToken {
    function add(uint[] memory a) external returns (uint) { return addTokenInt(a); }
}

contract Data is LedgerContractData {
    function add(string[] memory a) external returns (uint) { return addData(a); }
}

contract LedgerTest is Test {
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    LedgerUser user;
    event ContractsAdded(uint indexed _ID);

    function setUp() public {
        vm.prank(alice);
        user = new LedgerUser("My App", 3, 7, "uri");
    }

    function two() internal pure returns (address[] memory a) {
        a = new address[](2);
        a[0] = address(1);
        a[1] = address(2);
    }

    function test_DeployerHoldsTheKeysAndTheNameIsStored() public {
        assertEq(user.name(), "My App");
        assertEq(user.ledgerKeyToken(), 7);
        assertEq(user.balanceOf(alice, 7), 3);
    }

    function test_ConstructorRequiresAKey() public {
        vm.expectRevert("at least one key is required");
        new LedgerUser("My App", 0, 7, "uri");
    }

    function test_KeyHolderCanAddAndAnyoneCanRead() public {
        vm.warp(1000);
        vm.prank(alice);
        assertEq(user.addContract(two()), 0);
        vm.prank(alice);
        assertEq(user.addContract(two()), 1);
        assertEq(user.contractCount(), 2);
        vm.prank(bob);
        (address[] memory list, uint time, uint id, bool exist) = user.viewLedgerID(1);
        assertEq(list.length, 2);
        assertEq(list[1], address(2));
        assertEq(time, 1000);
        assertEq(id, 1);
        assertTrue(exist);
    }

    function test_AddingEmitsTheId() public {
        vm.expectEmit(true, false, false, false);
        emit ContractsAdded(0);
        vm.prank(alice);
        user.addContract(two());
    }

    function test_NonKeyHolderCannotAdd() public {
        vm.prank(bob);
        vm.expectRevert("you must hold a key");
        user.addContract(two());
    }

    function test_AccessMovesWithTheKey() public {
        vm.prank(alice);
        user.safeTransferFrom(alice, bob, 7, 3, "");
        vm.prank(bob);
        assertEq(user.addContract(two()), 0);
        vm.prank(alice);
        vm.expectRevert("you must hold a key");
        user.addContract(two());
    }

    function test_EmptyEntriesAreRefused() public {
        vm.prank(alice);
        vm.expectRevert("no addresses were given");
        user.addContract(new address[](0));
        Addresses a = new Addresses();
        vm.expectRevert("no addresses were given");
        a.add(new address[](0));
        Tokens t = new Tokens();
        vm.expectRevert("no tokens were given");
        t.add(new uint[](0));
        Data d = new Data();
        vm.expectRevert("no data was given");
        d.add(new string[](0));
    }

    function test_MissingEntriesReportThatTheyDoNotExist() public {
        (address[] memory list, uint time, , bool exist) = user.viewLedgerID(99);
        assertEq(list.length, 0);
        assertEq(time, 0);
        assertFalse(exist);
    }

    function test_AddressLedgerBase() public {
        Addresses a = new Addresses();
        assertEq(a.add(two()), 0);
        (address[] memory list, , , bool exist) = a.viewLedgerID(0);
        assertEq(list[0], address(1));
        assertTrue(exist);
        assertEq(a.contractCount(), 1);
    }

    function test_TokenLedgerBase() public {
        Tokens t = new Tokens();
        uint[] memory ids = new uint[](1);
        ids[0] = 42;
        assertEq(t.add(ids), 0);
        (uint[] memory list, , , bool exist) = t.viewIntLedgerID(0);
        assertEq(list[0], 42);
        assertTrue(exist);
        assertEq(t.setCount(), 1);
    }

    function test_DataLedgerBase() public {
        Data d = new Data();
        string[] memory text = new string[](1);
        text[0] = "note";
        assertEq(d.add(text), 0);
        (string[] memory list, , , bool exist) = d.viewDataLedgerID(0);
        assertEq(list[0], "note");
        assertTrue(exist);
        assertEq(d.setCount(), 1);
    }

    function testFuzz_IdsCountUpAndEntriesStaySeparate(uint8 count) public {
        uint n = bound(count, 1, 40);
        for (uint i = 0; i < n; i++) {
            address[] memory a = new address[](1);
            a[0] = address(uint160(i + 1));
            vm.prank(alice);
            assertEq(user.addContract(a), i);
        }
        for (uint i = 0; i < n; i++) {
            (address[] memory list, , uint id, ) = user.viewLedgerID(i);
            assertEq(list[0], address(uint160(i + 1)));
            assertEq(id, i);
        }
    }
}
