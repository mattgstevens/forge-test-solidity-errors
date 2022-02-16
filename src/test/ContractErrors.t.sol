// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

import {ContractErrors} from "../ContractErrors.sol";

contract ContractErrorsTest is DSTest {
    Vm internal immutable vm = Vm(HEVM_ADDRESS);

    Utilities internal utils;

    ContractErrors implementation;

    function setUp() public {
        utils = new Utilities();
        implementation = new ContractErrors();
    }

    function testErrorStringShort() public {
        vm.expectRevert("ErrorString");
        implementation.errorStringShort();
    }

    function testErrorStringLong() public {
        vm.expectRevert("ThisIsAVeryDescriptiveError");
        implementation.errorStringLong();
    }

    function testErrorStringConstantShort() public {
        // NOTE: must use abi.encodePacked here otherwise:
        //
        // Compiler run failed
        // TypeError: Member "expectRevert" not unique after argument-dependent lookup in contract Vm.
        vm.expectRevert(abi.encodePacked("E"));
        implementation.errorStringConstantShort();
    }

    function testErrorStringConstantLong() public {
        vm.expectRevert("ConstantErrorString");
        implementation.errorStringConstantLong();
    }

    function testErrorSolidity() public {
        vm.expectRevert(abi.encodeWithSignature("NoArgs()"));
        implementation.errorSolidity();
    }

    function testErrorSolidityArgsShort() public {
        uint256 shortNumber = 1;
        vm.expectRevert(
            abi.encodeWithSignature("WithArgs(uint256)", shortNumber)
        );
        implementation.errorSolidityArgs(shortNumber);
    }

    function testErrorSolidityArgsLong() public {
        uint256 longNumber = 123456;
        vm.expectRevert(
            abi.encodeWithSignature("WithArgs(uint256)", longNumber)
        );
        implementation.errorSolidityArgs(longNumber);
    }

    function testParseErrorWhenString() public {
        string memory errorReason = "PEW: lasers";
        bytes memory errorString = abi.encodeWithSignature(
            "Error(string)",
            errorReason
        );
        vm.expectRevert(abi.encodePacked(errorReason));

        implementation.parseError(errorString);
    }

    function testParseErrorWhenCustomError() public {
        bytes memory customError = abi.encodeWithSignature(
            "LaserStats(string, uint256, string)",
            "BFG",
            9001,
            "side"
        );
        vm.expectRevert(customError);

        implementation.parseError(customError);
    }

    function testParseEmptyRevert() public {
        bytes memory emptyError = new bytes(0);
        vm.expectRevert(emptyError);

        implementation.parseErrorEmptyRevert();
    }
}
