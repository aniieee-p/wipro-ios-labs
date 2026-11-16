import Foundation

// R1: Reusable Functions

func calculateMean(of numbers: [Double]) -> Double? {
    if numbers.isEmpty {
        return nil
    }
    var total = 0.0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

func findMaximum(in numbers: [Int]) -> Int? {
    if numbers.isEmpty {
        return nil
    }
    var max = numbers[0]
    for number in numbers {
        if number > max {
            max = number
        }
    }
    return max
}

func isValidEmail(_ email: String) -> Bool {
    // Basic check: must have exactly one @ with text on both sides
    let parts = email.split(separator: "@")
    if parts.count != 2 {
        return false
    }
    let local = String(parts[0])
    let domain = String(parts[1])
    if local.isEmpty || domain.isEmpty {
        return false
    }
    // Domain must contain a dot
    return domain.contains(".")
}

func formatDisplayName(_ name: String) -> String {
    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
    var words = trimmed.components(separatedBy: " ")
    var result = ""
    for word in words {
        if !word.isEmpty {
            let capitalized = word.prefix(1).uppercased() + word.dropFirst().lowercased()
            if result.isEmpty {
                result = capitalized
            } else {
                result = result + " " + capitalized
            }
        }
    }
    return result
}

// R2: Transactions

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

var totalExpenses = 0.0
for transaction in transactions {
    if transaction.isExpense {
        totalExpenses += transaction.amount
    }
}

print("\n=== R2: Transaction Analysis ===")
var expenseCount = 0
for transaction in transactions {
    if transaction.isExpense {
        expenseCount += 1
    }
}
print("Number of expenses: \(expenseCount)")
print("Total expenses: ₹\(totalExpenses)")

// Spending by category
let categories = ["Education", "Food", "Travel"]

print("\nSpending by Category:")
for category in categories {
    var categoryTotal = 0.0
    for transaction in transactions {
        if transaction.isExpense && transaction.category == category {
            categoryTotal += transaction.amount
        }
    }
    print("\(category): ₹\(categoryTotal)")
}

// R3: Sorting Students

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

// Sort by marks descending, then name ascending for ties
let sortedStudents = students.sorted { a, b in
    if a.marks != b.marks {
        return a.marks > b.marks
    }
    return a.name < b.name
}

print("\n=== R3: Students Sorted by Marks ===")
for student in sortedStudents {
    print("\(student.name): \(student.marks)")
}

// R4: Loop vs higher-order functions comparison

var loopTotal = 0.0
for transaction in transactions {
    if transaction.isExpense {
        loopTotal += transaction.amount
    }
}

let higherOrderTotal = transactions.filter { $0.isExpense }.map { $0.amount }.reduce(0, +)

print("\n=== R4: Comparing Approaches ===")
print("Loop-based total: ₹\(loopTotal)")
print("Higher-order total: ₹\(higherOrderTotal)")
print("Both approaches produce the same result.")

// R5 and R1 function tests

let meanResult = calculateMean(of: [70, 80, 90])
let maximumResult = findMaximum(in: [12, 45, 23, 67])
let validEmail = isValidEmail("anisha@example.com")
let invalidEmail = isValidEmail("anishaexample.com")
let displayName = formatDisplayName("  anisha patel  ")

print("\n=== Function Tests ===")
print("calculateMean: \(meanResult ?? 0)")
print("findMaximum: \(maximumResult ?? 0)")
print("Valid email: \(validEmail)")
print("Invalid email: \(invalidEmail)")
print("Formatted name: \(displayName)")

print("\n=== Lab 2A Completed ===")
