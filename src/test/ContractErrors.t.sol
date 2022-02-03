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
        implementation.errorStringShort();
    }

    function testErrorStringLong() public {
        implementation.errorStringLong();
    }

    function testErrorStringConstantShort() public {
        implementation.errorStringConstantShort();
    }

    function testErrorStringConstantLong() public {
        implementation.errorStringConstantLong();
    }

    function testErrorSolidity() public {
        implementation.errorSolidity();
    }

    function testErrorSolidityArgsShort() public {
        implementation.errorSolidityArgs(1);
    }

    function testErrorSolidityArgsLong() public {
        implementation.errorSolidityArgs(123456);
    }
}
