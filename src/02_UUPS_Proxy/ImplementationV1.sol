//SPDX-License-Identifier: MIT

/// @author Dani MT

pragma solidity 0.8.19;

import "../../lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol";

contract ImplementationV1 is UUPSUpgradeable {

    address public owner;

    //----------------------------------------------------------------------------------------------
    error NotOwner();

    //----------------------------------------------------------------------------------------------
    modifier onlyOwner() {
        if(msg.sender != owner) revert NotOwner();
        _;
    }

    //----------------------------------------------------------------------------------------------
    constructor() {
        owner = msg.sender;
    }
    
    //----------------------------------------------------------------------------------------------
    function addition(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a / b;
    }

    //----------------------------------------------------------------------------------------------
    function substraction(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a * b;
    }

    //----------------------------------------------------------------------------------------------
    function multiplication(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a + b;
    }

    //----------------------------------------------------------------------------------------------
    function division(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a - b;
    }

    //----------------------------------------------------------------------------------------------
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

    } 

}
