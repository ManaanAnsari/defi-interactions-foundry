// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {FlashLoanMultiple} from "../src/FlashLoanMultiple.sol";

contract DeployFlashLoanMultiple is Script {
    function run() public returns (address) {
        // Deploy FlashLoanMultiple
        vm.startBroadcast();
        FlashLoanMultiple flashLoanMultiple = new FlashLoanMultiple(0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A);
        vm.stopBroadcast();
        return address(flashLoanMultiple);
    }
}
