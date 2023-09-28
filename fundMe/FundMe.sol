// Get funds from users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        //Allow users to send $
        //Have a minimum 5$ sent
        //How do we send ETH to this contract?
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough $");  //1ETH
        msg.value.getConversionRate();
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;

    }

   

    function withdraw() public onlyOwnner {

        for(uint256 funderIndex = 0; funderIndex < funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        //reset the array
        // withdraw the funds

        //transfer
        // payable(msg.sender).transfer(address(this).balance);

        //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwnner(){
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable{
        fund();
    }
}