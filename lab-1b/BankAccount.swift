import Foundation

// MARK: - Bank Account

public class BankAccount {

    // Private: Balance cannot be accessed directly outside this class.
    private var balance: Double

    // Private: Transaction history is stored internally.
    private var transactionLog: [String] = []

    // Public: Account holder's name can be read but not changed externally.
    public let accountHolder: String

    // Public: Creates a bank account with valid initial details.
    public init?(accountHolder: String, initialBalance: Double) {
        guard !accountHolder.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              initialBalance >= 0 else {
            return nil
        }

        self.accountHolder = accountHolder
        self.balance = initialBalance
        transactionLog.append("Account opened with balance \(initialBalance)")
    }

    // Public: Allows callers to check the balance without modifying it.
    public var currentBalance: Double {
        return balance
    }

    // Extension: Read-only transaction history for external callers.
    public var transactions: [String] {
        return transactionLog
    }

    // Public: Deposits a valid positive amount.
    public func deposit(amount: Double) -> Bool {
        guard amount > 0 else {
            return false
        }

        balance += amount
        transactionLog.append("Deposited \(amount). New balance: \(balance)")
        return true
    }

    // Public: Withdraws only a valid amount within the available balance.
    public func withdraw(amount: Double) -> Bool {
        guard amount > 0, amount <= balance else {
            return false
        }

        balance -= amount
        transactionLog.append("Withdrew \(amount). New balance: \(balance)")
        return true
    }
}
