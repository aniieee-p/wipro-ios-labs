
import Foundation

// MARK: - Bank Account Demonstration

print("========== BANK ACCOUNT ==========")

if let account = BankAccount(accountHolder: "Anisha Patel", initialBalance: 1000) {

    print("Account Holder: \(account.accountHolder)")
    print("Initial Balance: \(account.currentBalance)")

    // Valid deposit
    print("\nDeposit 500: \(account.deposit(amount: 500) ? "Successful" : "Rejected")")
    print("Balance: \(account.currentBalance)")

    // Invalid deposits
    print("\nDeposit 0: \(account.deposit(amount: 0) ? "Successful" : "Rejected")")
    print("Deposit -100: \(account.deposit(amount: -100) ? "Successful" : "Rejected")")

    // Valid withdrawal
    print("\nWithdraw 300: \(account.withdraw(amount: 300) ? "Successful" : "Rejected")")
    print("Balance: \(account.currentBalance)")

    // Invalid withdrawals
    print("\nWithdraw 5000: \(account.withdraw(amount: 5000) ? "Successful" : "Rejected")")
    print("Withdraw -50: \(account.withdraw(amount: -50) ? "Successful" : "Rejected")")
    print("Withdraw 0: \(account.withdraw(amount: 0) ? "Successful" : "Rejected")")

    print("\nFinal Balance: \(account.currentBalance)")

} else {
    print("Account creation failed.")
}

// MARK: - Invalid Account Setup

print("\n========== ACCOUNT VALIDATION ==========")

let invalidNameAccount = BankAccount(accountHolder: "   ", initialBalance: 500)
let negativeBalanceAccount = BankAccount(accountHolder: "Anisha", initialBalance: -100)

print("Empty account holder: \(invalidNameAccount == nil ? "Rejected" : "Accepted")")
print("Negative initial balance: \(negativeBalanceAccount == nil ? "Rejected" : "Accepted")")

// MARK: - Access Control Demonstration

print("\n========== ACCESS CONTROL ==========")

let demo = AccessControlDemo()

// Private access through a public method
demo.displayPrivateMessage()

// Fileprivate access through a function in AccessControlDemo.swift
demonstrateFilePrivateAccess()

// Internal access from another file in the same module
print(demo.internalMessage)

// Public access
print(demo.publicMessage)

// Balance is read-only to callers.
// account.currentBalance = 5000 // Intentionally not allowed.
