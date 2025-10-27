// SPDX-License-Identifier: LicenseRef-Degensoft-ARSL-1.0-Audit

pragma solidity ^0.8.0;

interface IAquaMakerCallback {
    function aquaMakerCallback(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut,
        address taker,
        bytes calldata takerData
    ) external;
}
