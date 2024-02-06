// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

/// @title ejercicio de un proxy básico
/// @author Daniel Martínez Trinidad
/// @notice Esto es solo un ejercicio para practicar lo aprendido en clase
contract Proxy {
    address owner;
    address implementation;

    //------------------------------------------------------------------------
    error notOwner();
    error failedCall();

    //------------------------------------------------------------------------
    modifier onlyOwner {
        if(msg.sender != owner) revert notOwner();
        _;
    }

    //------------------------------------------------------------------------
    /// @param _implementation dirección del contrato de implementación inicial al que apunta el proxy
    constructor(address _implementation) {
        owner = msg.sender;
        implementation = _implementation;
    }

    //------------------------------------------------------------------------
    /// @notice Permite actualizar la implementación a la que apunta el contrato
    /// @notice Solo el propietario del contrato puede actualizar a una nueva implementación
    /// @param newImplementation Nueva dirección del contrato de implementación al que apuntar
    function upgrade(address newImplementation) external onlyOwner() {
        implementation = newImplementation;
    }

    //------------------------------------------------------------------------
    /// @notice Para redirigir las llamadas a hacia las implementaciones
    /// @param data Firma y parametros codificados de la función que se
    fallback(bytes calldata data) external returns(bytes memory) {
        (bool ok, bytes memory returnData) = address(implementation).delegatecall(data);
        if (!ok) revert failedCall();
        return returnData;
    }
}
