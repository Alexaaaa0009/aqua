// SPDX-License-Identifier: LicenseRef-Degensoft-ARSL-1.0-Audit

pragma solidity ^0.8.0; // tload/tstore are available since 0.8.24

import { TransientLock, TransientLockLib } from "./TransientLock.sol";

/// @dev Base contract with reentrancy guard functionality using transient storage locks.
///
/// Use private _lock defined in this contract:
/// ```solidity
/// function swap(...) external nonReentrant {
/// function doMagic(...) external onlyNonReentrantCall {
/// ```
///
/// Or use your own locks for more granular control:
/// ```solidity
/// TransientLock private _myLock;
/// function swap(...) external nonReentrantLock(_myLock) {
/// function doMagic(...) external onlyNonReentrantCallLock(_myLock) {
/// ```
///
abstract contract ReentrancyGuard {
    using TransientLockLib for TransientLock;

    error MissingNonReentrantModifier();

    TransientLock private _lock;

    modifier nonReentrant {
        _lock.lock();
        _;
        _lock.unlock();
    }

    modifier onlyNonReentrantCall {
        require(_inNonReentrantCall(), MissingNonReentrantModifier());
        _;
    }

    modifier nonReentrantLock(TransientLock storage lock) {
        lock.lock();
        _;
        lock.unlock();
    }

    modifier onlyNonReentrantCallLock(TransientLock storage lock) {
        require(lock.isLocked(), MissingNonReentrantModifier());
        _;
    }

    function _inNonReentrantCall() internal view returns (bool) {
        return _lock.isLocked();
    }
}
