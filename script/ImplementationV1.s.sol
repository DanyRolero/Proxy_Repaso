// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

/// @dev Indicar ruta del contrto a desplegar
import "../src/02_UUPS_Proxy/ImplementationV1.sol";

contract DeployImpl1 is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address account = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        /// @dev Instanciar contrato para ejecutar el despliegue
        ImplementationV1 impl1 = new ImplementationV1();

        /// @dev Obtener la dirección del contrato recién desplegado
        console.log(account);

        vm.stopBroadcast();
    }
}
