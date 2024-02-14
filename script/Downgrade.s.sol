// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

//----------------------------------------------------------------------------------------------
interface IImplementation {
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
    function getImplementation() external view returns (address);
}

contract Downgrade is Script {
    address implementation1 = 0x5C2c649f85978a5AB0fDad76eAc6B30f36895fFa;
    address implementation2 = 0x7916bF0627FBf23210Be41e23acE7bc9a1Fa4637;
    address proxy = 0xA7B6bDf28107EE4e7714cC7a23913f19c2A9db91;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address account = vm.addr(deployerPrivateKey);
        vm.startBroadcast(account);
        console.log(IImplementation(proxy).getImplementation());
        IImplementation(proxy).upgradeToAndCall(implementation1, "");
        console.log(IImplementation(proxy).getImplementation());
        vm.stopBroadcast();
    }
}