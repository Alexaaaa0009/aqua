// SPDX-License-Identifier: LicenseRef-Degensoft-ARSL-1.0-Audit
pragma solidity 0.8.30;

import { Script } from "forge-std/Script.sol";

import { Config } from "./utils/Config.sol";

import { AquaRouter } from "../src/AquaRouter.sol";

// solhint-disable no-console
import { console2 } from "forge-std/console2.sol";

contract DeployAquaRouter is Script {
    using Config for *;

    function run() external {
        (
            string memory name,
            string memory version
        ) = vm.readAquaRouterParameters();

        vm.startBroadcast();
        AquaRouter aquaRouter = new AquaRouter(
            name,
            version
        );
        vm.stopBroadcast();

        console2.log("AquaRouter deployed at: ", address(aquaRouter));
    }
}
// solhint-enable no-console
