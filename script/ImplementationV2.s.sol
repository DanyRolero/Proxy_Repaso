// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

/// @dev Indicar ruta del contrto a desplegar
import "../src/02_UUPS_Proxy/ImplementationV2.sol";

contract DeployImpl2 is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address account = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        /// @dev Instanciar contrato para ejecutar el despliegue
        ImplementationV2 impl2 = new ImplementationV2();

        /// @dev Obtener la dirección del contrato recién desplegado
        console.log(account);

        vm.stopBroadcast();
    }
}
