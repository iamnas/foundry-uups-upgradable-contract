// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

// import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract DeployBox is Script {
    function run() external returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 box = new BoxV1();
        ERC1967Proxy proxyAddress = new ERC1967Proxy(address(box), "");
        // address proxy = Upgrades.deployUUPSProxy(
        //     "MyContract.sol",
        //     abi.encodeCall(
        //         MyContract.initialize,
        //         ("arguments for the initialize function")
        //     )
        // );
        vm.stopBroadcast();
        return address(proxyAddress);
    }
}
