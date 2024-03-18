// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {FlashLoanSimpleReceiverBase} from "@aave/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract FlashLoan is FlashLoanSimpleReceiverBase {
    address public owner;

    constructor(address provider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(provider)) {
        owner = msg.sender;
    }

    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata params)
        external
        override
        returns (bool)
    {
        // Do something with the borrowed amount
        uint256 amountOwed = amount + premium;
        IERC20(asset).approve(address(POOL), amountOwed);
        return true;
    }

    function requestFlashLoan(address asset, uint256 amount) public onlyOwner returns (bool) {
        address receiverAddress = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;
        POOL.flashLoanSimple(receiverAddress, asset, amount, params, referralCode);
        return true;
    }

    function getBalanceOf(IERC20 asset) external view returns (uint256) {
        return asset.balanceOf(address(this));
    }

    function withdraw(IERC20 asset) external onlyOwner {
        asset.transfer(owner, asset.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "ONLY_OWNER");
        _;
    }
}
