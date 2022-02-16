// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.7;

// @notice a library to handle reading errors when calling contract
//
// how to handle errors:
// https://ethereum.stackexchange.com/questions/83528/how-can-i-get-the-revert-reason-of-a-call-in-solidity-so-that-i-can-use-it-in-th/83577#83577
//
// how to parse revert errors:
// https://docs.soliditylang.org/en/v0.8.11/control-structures.html?highlight=custom%20error#revert
//
// how to parse custom error:
// https://blog.soliditylang.org/2021/04/21/custom-errors/
library ErrorHandlerLib {
    error ExecutionReverted();

    function parseError(bytes memory error)
        internal
        pure
        returns (string memory)
    {
        if (error.length > 0) {
            // the call reverted with a error string or a custom error.
            assembly {
                let error_size := mload(error)
                revert(add(32, error), error_size)
            }
        } else {
            revert();
        }
    }
}
