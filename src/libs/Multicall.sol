// SPDX-License-Identifier: LicenseRef-Degensoft-ARSL-1.0-Audit

pragma solidity 0.8.30;

contract Multicall {
    function multicall(bytes[] calldata data) external {
        for (uint256 i = 0; i < data.length; i++) {
            (bool success,) = address(this).delegatecall(data[i]);
            if (!success) {
                assembly ("memory-safe") {
                    let ptr := mload(0x40)
                    returndatacopy(ptr, 0, returndatasize())
                    revert(ptr, returndatasize())
                }
            }
        }
    }
}
