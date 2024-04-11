// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/my_MockERC20.sol";
import "../src/my_Vault.sol";

contract VaultAndTokenTest is Test {
    MockERC20 token;
    BasicVault vault;
    address user = address(1); // Use a test address

    function setUp() public {
        // Deploy the token and the vault with an initial supply
        token = new MockERC20("MockToken", "MTK", 1e18);
        vault = new BasicVault(token);

        // Setup testing environment: transfer tokens to the user and approve them to the vault
        token.transfer(user, 1e18);
        vm.prank(user);
        token.approve(address(vault), 1e18);
    }

    function testDeposit() public {
        uint256 initialBalance = token.balanceOf(user);
        uint256 depositAmount = 1e18;

        vm.prank(user);
        vault.deposit(depositAmount);

        // Check if the tokens are correctly deposited in the vault
        assertEq(vault.balanceOf(user), depositAmount, "Deposit was not recorded correctly.");
        assertEq(token.balanceOf(user), initialBalance - depositAmount, "Token balance was not deducted correctly.");
    }

    function testWithdraw() public {
        uint256 depositAmount = 1e18;

        // First, deposit tokens into the vault
        vm.prank(user);
        vault.deposit(depositAmount);

        // Then, attempt to withdraw the same amount
        vm.prank(user);
        vault.withdraw(depositAmount);

        // Verify the final balances after withdrawal
        assertEq(vault.balanceOf(user), 0, "Withdrawal was not recorded correctly.");
        assertEq(token.balanceOf(user), 1e18, "Token balance was not restored correctly.");
    }
}
