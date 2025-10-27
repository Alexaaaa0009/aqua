// SPDX-License-Identifier: LicenseRef-Degensoft-ARSL-1.0-Audit

pragma solidity 0.8.30;

import { Context } from "@openzeppelin/contracts/utils/Context.sol";
import { SafeERC20, IERC20 } from "@1inch/solidity-utils/contracts/libraries/SafeERC20.sol";
import { BySig, EIP712 } from "@1inch/solidity-utils/contracts/mixins/BySig.sol";

import { Aqua } from "./Aqua.sol";
import { Simulator } from "./libs/Simulator.sol";
import { Multicall } from "./libs/Multicall.sol";

contract AquaRouter is Aqua, Simulator, Multicall, BySig {
    using SafeERC20 for IERC20;

    constructor(string memory name, string memory version) EIP712(name, version) { }

    function _chargeSigner(
        address signer,
        address relayer,
        address token,
        uint256 amount,
        bytes calldata /* extraData */
    ) internal override {
        IERC20(token).safeTransferFrom(signer, relayer, amount);
    }

    function _msgSender() internal view override(BySig, Context) returns (address) {
        return BySig._msgSender();
    }
}
