// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";


/// @title ejercicio de proxy básico UUPS
/// @author Daniel Martínez Trinidad
/// @notice Esto es solo un ejercicio para practicar lo aprendido en clase
/// @notice UUPS (Universal Upgradeable Proxy Standard)
contract UUPSProxy is ERC1967Proxy {

    constructor(address implementation, bytes memory _data) ERC1967Proxy(implementation, _data){}

    function _implementation() internal view override returns (address) {
        
    }   

 }