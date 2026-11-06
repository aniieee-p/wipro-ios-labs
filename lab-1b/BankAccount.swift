
import Foundation

// MARK: - Bank Account

public class BankAccount {

    // Private: Balance cannot be accessed directly outside this class.
    private var balance: Double

    // Public: Account holder's name can be read but not changed externally.
    public let accountHolder: String

    // Public: Creates a bank account with valid initial details.
    public init?(accountHolder: String, initialBalance: Double) {
        guard !accountHolder.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              initialBalance.isFinite,
              initialBalance >= 0 else {
            return nil
        }

        self.accountHolder = accountHolder
        self.balance = initialBalance
    }

    // Public: Allows callers to check the balance without modifying it.
    public var currentBalance: Double {
        return balance
    }

    // Public: Deposits a valid positive amount.
    public func deposit(amount: Double) -> Bool {
        guard amount.isFinite, amount > 0 else {
            return false
        }

        balance += amount
        return true
    }

    // Public: Withdraws only a valid amount within the available balance.
    public func withdraw(amount: Double) -> Bool {
        guard amount.isFinite,
              amount > 0,
              amount <= balance else {
            return false
        }

        balance -= amount
        return true
    }
}
