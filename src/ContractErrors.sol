// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.7;

import {ErrorHandlerLib} from "./ErrorHandlerLib.sol";

contract ContractErrors {
    error NoArgs();
    error WithArgs(uint256 amount);

    string private constant ERROR_STRING_SHORT = "E";
    string private constant ERROR_STRING_LONG = "ConstantErrorString";

    function errorStringShort() public {
        revert("ErrorString");
    }

    function errorStringLong() public {
        revert("ThisIsAVeryDescriptiveError");
    }

    function errorStringConstantShort() public {
        revert(ERROR_STRING_SHORT);
    }

    function errorStringConstantLong() public {
        revert(ERROR_STRING_LONG);
    }

    function errorCustom() public {
        revert NoArgs();
    }

    function errorCustomArgs(uint256 amount) public {
        revert WithArgs(amount);
    }

    //
    // --- direct calls to parseError
    //

    function parseError(bytes memory data) public {
        ErrorHandlerLib.parseError(data);

        revert("should not be here");
    }

    //
    // --- contract calls to parseError
    //

    function callWithEmptyRevert() public {
        Reverted reverter = new Reverted();

        try reverter.emptyRevert() {} catch (bytes memory data) {
            ErrorHandlerLib.parseError(data);
        }
    }

    function callWithErrorString() public {
        Reverted reverter = new Reverted();

        try reverter.errorString() {} catch (bytes memory data) {
            ErrorHandlerLib.parseError(data);
        }
    }

    function callWithPanic() public {
        Reverted reverter = new Reverted();

        try reverter.panic() {} catch (bytes memory data) {
            ErrorHandlerLib.parseError(data);
        }
    }

    function callWithCustomError() public {
        Reverted reverter = new Reverted();

        try reverter.customError() {} catch (bytes memory data) {
            ErrorHandlerLib.parseError(data);
        }
    }

}

contract Reverted {
    error CrashBoomBang();

    constructor() {}

    function emptyRevert() public {
        revert();
    }

    function errorString() public {
        revert('boom');
    }

    function panic() public {
        uint256 x = type(uint256).max;
        x += 1;
    }

    function customError() public {
        revert CrashBoomBang();
    }

}
