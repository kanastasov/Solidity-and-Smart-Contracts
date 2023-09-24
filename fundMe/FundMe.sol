// Get funds from users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumUsd = 1e10;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;


    function fund() public payable{
        //Allow users to send $
        //Have a minimum 5$ sent
        //How do we send ETH to this contract?
        require(getConversionRate(msg.value) > minimumUsd, "didn't send enough $");  //1ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] =  addressToAmountFunded[msg.sender] + msg.value;

    }

    function getPrice() public view returns(uint256){
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306 
        //ABI 

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (uint80 roundId, int256 price, uint256 startedAt, uint256 timestamp, uint80 anwsweredInRound) = priceFeed.latestRoundData();
        // price of ETH in terms of USD
        return uint256(price * 1e10);

    }

    function getVersion() public view returns(uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();

    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        //1 ETH?
        //2000_000000000000 * 1_000000000000 / 1e18 = 2000
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsed = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsed;

    }

    function withdraw() public {}
}