// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.7;

contract ContractErrors {
    error NoArgs();
    error WithArgs(uint256 amount);

    string constant private ERROR_STRING_SHORT = "E";
    string constant private ERROR_STRING_LONG = "ConstantErrorString";


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
}
