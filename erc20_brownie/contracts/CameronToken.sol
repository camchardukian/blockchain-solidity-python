// contracts/CameronToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CameronToken is ERC20 {
    // initialSupply in wei
    constructor(uint256 initialSupply) ERC20("CameronToken", "CamToken") {
        _mint(msg.sender, initialSupply);
    }
}
