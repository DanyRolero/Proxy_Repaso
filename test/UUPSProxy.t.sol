// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/forge-std/src/Test.sol";
import "../src/02_UUPS_Proxy/Proxy.sol";
import "../src/02_UUPS_Proxy/CalculatorV1.sol";
import "../src/02_UUPS_Proxy/CalculatorV2.sol";

//----------------------------------------------------------------------------------------------
interface ICalculator {
    function addition(uint256 a, uint256 b) external pure returns(uint256 result);
    function substraction(uint256 a, uint256 b) external pure returns(uint256 result);
    function multiplication(uint256 a, uint256 b) external pure returns(uint256 result);
    function division(uint256 a, uint256 b) external pure returns(uint256 result);
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}

contract UUPSProxyTest is Test {
    uint256 num1 = 6;
    uint256 num2 = 3;
    ImplementationV1 impl1;
    UUPSProxy proxy;
    ImplementationV2 impl2;


    function setUp() public {
        impl1 = new ImplementationV1();
        proxy = new UUPSProxy(address(impl1), "");
        impl2 = new ImplementationV2();
    }

    function test_getImplementation() public {
        assertEq(address(impl1), proxy.getImplementation());

    }

    function test_upgrade() public {
        ICalculator(address(proxy)).upgradeToAndCall(address(impl2),"");
        assertEq(address(impl2), proxy.getImplementation());
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 + 3 but is 6 / 3
    function test_wrong_addiction() public {
        uint256 result = ICalculator(address(proxy)).addition(num1, num2);
        assertFalse(result == 9);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 - 3 but is 6 * 3
    function test_wrong_substraction() public {
        uint256 result = ICalculator(address(proxy)).substraction(num1, num2);
        assertFalse(result == 3);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 x 3 but is 6 + 3
    function test_wrong_multiplication() public {
        uint256 result = ICalculator(address(proxy)).multiplication(num1, num2);
        assertFalse(result == 18);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 / 3 but is 6 - 3
    function test_wrong_division() public {
        uint256 result = ICalculator(address(proxy)).division(num1, num2);
        assertFalse(result == 2);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 + 3
    function test_correct_addiction() public {
        ICalculator(address(proxy)).upgradeToAndCall(address(impl2),"");
        uint256 result = ICalculator(address(proxy)).addition(num1, num2);
        assertEq(result, 9);       
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 - 3
    function test_correct_substraction() public {
        ICalculator(address(proxy)).upgradeToAndCall(address(impl2),"");
        uint256 result = ICalculator(address(proxy)).substraction(num1, num2);
        assertEq(result, 3);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 x 3
    function test_correct_multiplication() public {
        ICalculator(address(proxy)).upgradeToAndCall(address(impl2),"");
        uint256 result = ICalculator(address(proxy)).multiplication(num1, num2);
        assertEq(result, 18);
    }

    //--------------------------------------------------------------------------------
    /// @notice expected 6 / 3
    function test_correct_division() public {
        ICalculator(address(proxy)).upgradeToAndCall(address(impl2),"");
        uint256 result = ICalculator(address(proxy)).division(num1, num2);
        assertEq(result, 2);
    }


}