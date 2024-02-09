// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";

//----------------------------------------------------------------------------------------------
interface IImplementation {
    function owner() external returns (address);
    function addition(uint256 a, uint256 b) external pure returns(uint256 result);
    function substraction(uint256 a, uint256 b) external pure returns(uint256 result);
    function multiplication(uint256 a, uint256 b) external pure returns(uint256 result);
    function division(uint256 a, uint256 b) external pure returns(uint256 result);
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}


//----------------------------------------------------------------------------------------------
/// @title ejercicio de proxy básico UUPS
/// @author Daniel Martínez Trinidad
/// @notice Esto es solo un ejercicio para practicar lo aprendido en clase
/// @notice UUPS (Universal Upgradeable Proxy Standard)
contract UUPSProxy is ERC1967Proxy {
    address public owner;

    //----------------------------------------------------------------------------------------------
    constructor(address implementation, bytes memory _data) ERC1967Proxy(implementation, _data) {
        owner = IImplementation(address(implementation)).owner();
    }   

    //----------------------------------------------------------------------------------------------
    function getImplementation() external view returns (address) {
        return _implementation();
    }

    receive() external payable {}

 }