// SPDX-License-Identifier: LicenseRef-Degensoft-ARSL-1.0-Audit

pragma solidity ^0.8.0;

struct Balance {
    uint248 amount;
    uint8 tokensCount;
}

library BalanceLib {
    /// @dev Assembly implementation to make sure exactly 1 SLOAD is being used
    function load(Balance storage balance) internal view returns (uint248 amount, uint8 tokensCount) {
        assembly ("memory-safe") {
            let packed := sload(balance.slot)
            amount := and(packed, 0x00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            tokensCount := shr(248, packed)
        }
    }

    /// @dev Assembly implementation to make sure exactly 1 SSTORE is being used
    function store(Balance storage balance, uint248 amount, uint8 tokensCount) internal {
        assembly ("memory-safe") {
            let packed := or(amount, shl(248, tokensCount))
            sstore(balance.slot, packed)
        }
    }
}
