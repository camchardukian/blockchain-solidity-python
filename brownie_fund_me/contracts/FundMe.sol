// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

// The Application Binary Interface tells Solidity and other programming languages how it can interact with another contract.
// We need an ABI anytime we want to interact with a smart contract that is already deployed.
contract FundMe {
    using SafeMathChainlink for uint256;
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    AggregatorV3Interface public priceFeed;

    // the first person to deploy the contract is the owner.
    constructor(address _priceFeed) public {
        priceFeed = AggregatorV3Interface(_priceFeed);
        owner = msg.sender;
    }

    // We can create a function that can be used to pay with ETH/Ethereum by including the usage of
    // the "payable" keyword while defining said function
    function fund() public payable {
        // minimum $50 for successful transactions based on the two lines below.
        uint256 minimumUSD = 50 * 10**18;
        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to send at least 50 USD for a successful transaction"
        );
        // msg.sender and msg.value are keywords in every contract call.
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        // When we return values from tuples we can use commas as placeholders for returned values we don't intend to use.
        // This makes our code cleaner and more concise.
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    function getEntranceFee() public view returns (uint256) {
        uint256 minimumUSD = 50 * 10**18;
        uint256 price = getPrice();
        uint256 precision = 1 * 10**18;
        return ((minimumUSD * precision) / price) + 1;
    }

    modifier onlyOwner() {
        // only allow the contract admin/owner to withdraw funds
        require(msg.sender == owner);
        _;
    }

    function withdraw() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}

// Notes:
// Can get ETH to FIAT currency pricefeed here: https://docs.chain.link/docs/ethereum-addresses/
// ETH Unit Converter: https://eth-converter.com/
// In versions of solidity prior to 0.8 we needed to worry about "number wrapping".
