// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/forge-std/src/Test.sol";
import "../src/01_Proxy/Proxy.sol";
import "../src/01_Proxy/CalculatorV1.sol";
import "../src/01_Proxy/CalculatorV2.sol";

interface ICalculator {
    function addition(uint256 a, uint256 b) external pure returns(uint256);
    function substraction(uint256 a, uint256 b) external pure returns(uint256);
    function multiplication(uint256 a, uint256 b) external pure returns(uint256);
    function division(uint256 a, uint256 b) external pure returns(uint256);
}

contract ProxyTest is Test {
    Proxy public proxy;
    address dani = makeAddr("Dani");

    ImplementationV1 implementation1 = new ImplementationV1();
    ImplementationV2 implementation2 = new ImplementationV2();

    uint256 num1 = 6;
    uint256 num2 = 3;

    error failedCall();

    bytes additionSig = abi.encodeWithSignature("addition(uint256,uint256)", num1, num2);
    bytes substractionSig = abi.encodeWithSignature("substraction(uint256,uint256)", num1, num2);
    bytes multiplicationSig = abi.encodeWithSignature("multiplication(uint256,uint256)", num1, num2);
    bytes divisionSig = abi.encodeWithSignature("division(uint256,uint256)", num1, num2);


    //--------------------------------------------------------------------------------
    function setUp() public {
        vm.startPrank(dani);
        proxy = new Proxy(address(implementation1));
    }
    
    //--------------------------------------------------------------------------------
    /// @notice expected 6 + 3 but is 6 / 3
    function test_wrong_addiction() public {
        (bool ok,bytes memory resultData) = address(proxy).call(additionSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertFalse(result == 9);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 - 3 but is 6 * 3
    function test_wrong_substraction() public {
        (bool ok,bytes memory resultData) = address(proxy).call(substractionSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertFalse(result == 3);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 x 3 but is 6 + 3
    function test_wrong_multiplication() public {
        (bool ok,bytes memory resultData) = address(proxy).call(multiplicationSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertFalse(result == 18);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 / 3 but is 6 - 3
    function test_wrong_division() public {
        (bool ok,bytes memory resultData) = address(proxy).call(divisionSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertFalse(result == 2);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 + 3
    function test_correct_addiction() public {
        proxy.upgrade(address(implementation2));

        (bool ok,bytes memory resultData) = address(proxy).call(additionSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertEq(result, 9);       
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 - 3
    function test_correct_substraction() public {
        proxy.upgrade(address(implementation2));

        (bool ok,bytes memory resultData) = address(proxy).call(substractionSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertEq(result, 3);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 x 3
    function test_correct_multiplication() public {
        proxy.upgrade(address(implementation2));

        (bool ok,bytes memory resultData) = address(proxy).call(multiplicationSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertEq(result, 18);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 / 3
    function test_correct_division() public {
        proxy.upgrade(address(implementation2));

        (bool ok,bytes memory resultData) = address(proxy).call(divisionSig);
        if(!ok) revert failedCall();
        uint256 result = abi.decode(resultData, (uint256));
        assertEq(result, 2);
    }
    
}
