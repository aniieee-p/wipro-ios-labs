
import Foundation

// MARK: - R1: Reusable Functions

func calculateMean(of numbers: [Double]) -> Double? {
    guard !numbers.isEmpty else {
        return nil
    }

    let total = numbers.reduce(0, +)
    return total / Double(numbers.count)
}

func findMaximum(in numbers: [Int]) -> Int? {
    return numbers.max()
}

func isValidEmail(_ email: String) -> Bool {
    let parts = email.split(separator: "@", omittingEmptySubsequences: false)

    guard parts.count == 2,
          !parts[0].isEmpty,
          !parts[1].isEmpty,
          let dotIndex = parts[1].lastIndex(of: ".") else {
        return false
    }

    return dotIndex != parts[1].startIndex &&
           parts[1].index(after: dotIndex) < parts[1].endIndex
}

func formatDisplayName(_ name: String) -> String {
    return name
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .split(separator: " ")
        .map { $0.capitalized }
        .joined(separator: " ")
}

// MARK: - R2: Transactions and Higher-Order Functions

struct Transaction {
    let title: String
    let category: String
    let amount: Double
    let isExpense: Bool
}

let transactions: [Transaction] = [
    Transaction(title: "Groceries", category: "Food", amount: 1200, isExpense: true),
    Transaction(title: "Salary", category: "Income", amount: 25000, isExpense: false),
    Transaction(title: "Bus pass", category: "Travel", amount: 800, isExpense: true),
    Transaction(title: "Restaurant", category: "Food", amount: 600, isExpense: true),
    Transaction(title: "Books", category: "Education", amount: 1500, isExpense: true)
]

let expenses = transactions.filter { $0.isExpense }

let expenseAmounts = expenses.map { $0.amount }

let totalExpenses = expenseAmounts.reduce(0, +)

print("\n=== R2: Transaction Analysis ===")
print("Number of expenses: \(expenses.count)")
print("Expense amounts: \(expenseAmounts)")
print("Total expenses: ₹\(totalExpenses)")

// Optional extension: Spending by category

let categories = Set(expenses.map { $0.category }).sorted()

print("\nSpending by Category:")

for category in categories {
    let categoryTotal = expenses
        .filter { $0.category == category }
        .map { $0.amount }
        .reduce(0, +)

    print("\(category): ₹\(categoryTotal)")
}

// MARK: - R3: Sorting Students

struct Student {
    let name: String
    let marks: Int
}

let students: [Student] = [
    Student(name: "Riya", marks: 85),
    Student(name: "Aman", marks: 92),
    Student(name: "Neha", marks: 85),
    Student(name: "Karan", marks: 78),
    Student(name: "Anisha", marks: 92)
]

let sortedStudents = students.sorted {
    if $0.marks != $1.marks {
        return $0.marks > $1.marks
    }

    return $0.name < $1.name
}

print("\n=== R3: Students Sorted by Marks and Name ===")

for student in sortedStudents {
    print("\(student.name): \(student.marks)")
}

// MARK: - R4: Loop-Based vs Higher-Order Functions

let loopTotal = {
    var total = 0.0

    for transaction in transactions {
        if transaction.isExpense {
            total += transaction.amount
        }
    }

    return total
}()

let higherOrderTotal = transactions
    .filter { $0.isExpense }
    .map { $0.amount }
    .reduce(0, +)

print("\n=== R4: Comparing Approaches ===")
print("Loop-based total: ₹\(loopTotal)")
print("Higher-order total: ₹\(higherOrderTotal)")
print("Both approaches produce the same result.")

// MARK: - R5: Clear Parameters and Return Types

print("\n=== R1 and R5: Function Tests ===")

let meanResult = calculateMean(of: [70, 80, 90])
let maximumResult = findMaximum(in: [12, 45, 23, 67])

let validEmail = isValidEmail("anisha@example.com")
let invalidEmail = isValidEmail("anishaexample.com")

let displayName = formatDisplayName("  anisha patel  ")

print("Function Test Results:")
print("calculateMean: \(meanResult ?? 0)")
print("findMaximum: \(maximumResult ?? 0)")
print("Valid email: \(validEmail)")
print("Invalid email: \(invalidEmail)")
print("Formatted name: \(displayName)")

// MARK: - Test Table

print("\n=== Lab 2A: Test Table ===")
print("Test Case                 | Expected       | Actual")

print("Mean of [70,80,90]        | 80.0           | \(meanResult ?? 0)")
print("Maximum of [12,45,23,67]  | 67             | \(maximumResult ?? 0)")
print("Valid email               | true           | \(validEmail)")
print("Invalid email             | false          | \(invalidEmail)")
print("Formatted display name    | Anisha Patel   | \(displayName)")

print("\n=== Lab 2A Completed ===")

