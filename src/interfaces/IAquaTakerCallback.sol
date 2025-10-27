// SPDX-License-Identifier: LicenseRef-Degensoft-ARSL-1.0-Audit

pragma solidity ^0.8.0;

interface IAquaTakerCallback {
    function aquaTakerCallback(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut,
        address maker,
        address implementation,
        bytes32 strategyHash,
        bytes calldata takerData
    ) external;
}
