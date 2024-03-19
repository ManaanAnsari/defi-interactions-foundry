// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {FlashLoanReceiverBase} from "@aave/contracts/flashloan/base/FlashLoanReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/contracts/interfaces/IPoolAddressesProvider.sol";
import {IPool} from "@aave/contracts/interfaces/IPool.sol";
import {IERC20} from "@aave/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract FlashLoanMultiple is FlashLoanReceiverBase {
    address public owner;

    constructor(address provider) FlashLoanReceiverBase(IPoolAddressesProvider(provider)) {
        owner = msg.sender;
    }

    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        // Do something with the borrowed amount
        for (uint256 i = 0; i < assets.length; i++) {
            IERC20(assets[i]).approve(address(POOL), amounts[i] + premiums[i]);
        }

        return true;
    }

    function requestFlashLoan(address[] memory assets, uint256[] memory amounts) public onlyOwner returns (bool) {
        require(assets.length == amounts.length, "Assets and amounts length mismatch");

        address receiverAddress = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        // Initialize the debt array with the same length as assets and amounts
        uint256[] memory debt = new uint256[](assets.length);
        // Assuming the debt is to be calculated or set to specific values based on business logic
        // For now, initializing it with zeroes or specific values as per your requirement
        for (uint256 i = 0; i < assets.length; i++) {
            // Set debt values here if needed, for example:
            // debt[i] = amounts[i] + (amounts[i] * interestRate / 10000); // Example calculation
            debt[i] = 0; // If there's no additional debt calculation required
        }

        POOL.flashLoan(receiverAddress, assets, amounts, debt, address(this), params, referralCode);
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
