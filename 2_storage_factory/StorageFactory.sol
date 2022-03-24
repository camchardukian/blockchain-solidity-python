// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "1_simple_storage/SimpleStorage.sol";

// by using the keyword "is" we can inherit from another contract.
contract StorageFactory is SimpleStorage {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        // We need an Address and an ABI (Application Binary Interface) anytime we want to interact with a contract
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(
            _simpleStorageNumber
        );
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]))
                .retrieve();
    }
}
