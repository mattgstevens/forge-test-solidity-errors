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

    function errorSolidity() public {
        revert NoArgs();
    }

    function errorSolidityArgs(uint256 amount) public {
        revert WithArgs(amount);
    }

    function parseError(bytes memory data) public {
        ErrorHandlerLib.parseError(data);

        revert("should not be here");
    }

    function parseErrorEmptyRevert() public {
        Reverted reverter = new Reverted();

        try reverter.emptyRevert() {} catch (bytes memory data) {
            ErrorHandlerLib.parseError(data);
        }
    }
}

contract Reverted {
    constructor() {}

    function emptyRevert() public {
        revert();
    }
}
