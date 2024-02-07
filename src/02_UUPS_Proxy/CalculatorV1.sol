//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol";

contract ImplementationV1 is UUPSUpgradeable {
    
    function addition(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a / b;
    }

    function substraction(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a * b;
    }

    function multiplication(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a + b;
    }

    function division(uint256 a, uint256 b) external pure returns(uint256 result) {
        result = a - b;
    }

}
