// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

// Define an interface for the UUPS proxy's upgradeTo function
interface IUUPSProxy {
    function upgradeTo(address newImplementation) external;
}

contract UpgradeBox is Script {
    function run() external returns (address) {
        address proxyAddress = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );

        vm.startBroadcast();

        BoxV2 newImplementation = new BoxV2();
        vm.stopBroadcast();

        address upgradedProxy = upgradeBox(
            proxyAddress,
            address(newImplementation)
        );

        return upgradedProxy;
    }

    // function upgradeBox(
    //     address oldAddress,
    //     address newBox
    // ) public returns (address) {
    //     vm.startBroadcast();

    //     BoxV1 proxy = BoxV1(oldAddress);
    //     proxy.upgradeTo(address(proxy));

    //     vm.stopBroadcast();

    //     return address(proxy);
    // }

     function upgradeBox(address proxyAddress, address newImplementation) public returns (address) {
        vm.startBroadcast();

        // Cast proxyAddress to the BoxV1 interface
        IUUPSProxy proxy = IUUPSProxy(proxyAddress);

        // Call upgradeTo with the new implementation address
        proxy.upgradeTo(newImplementation);

        vm.stopBroadcast();

        return proxyAddress;
    }
}
