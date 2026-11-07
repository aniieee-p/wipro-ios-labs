import Foundation

// MARK: - R1: Gradebook using Arrays, Dictionaries and Safe Optionals

struct Student {
    let id: Int
    let name: String
    var marks: [String: Double]
}

var students: [Student] = [
    Student(id: 101, name: "Aarav", marks: ["Swift": 85, "iOS": 90, "OOP": 88]),
    Student(id: 102, name: "Diya", marks: ["Swift": 92, "iOS": 87, "OOP": 95]),
    Student(id: 103, name: "Kabir", marks: ["Swift": 76, "iOS": 81, "OOP": 79])
]

// Add a student using the array.
students.append(
    Student(id: 104, name: "Meera", marks: ["Swift": 89, "iOS": 93, "OOP": 91])
)

// Safely find a student by ID.
func findStudent(id: Int) -> Student? {
    return students.first { $0.id == id }
}

// Safely calculate a student's average.
func calculateAverage(for student: Student) -> Double? {
    guard !student.marks.isEmpty else {
        return nil
    }

    let total = student.marks.values.reduce(0, +)
    return total / Double(student.marks.count)
}

// Safely retrieve marks for a subject.
func getMarks(for subject: String, student: Student) -> Double? {
    return student.marks[subject]
}

// Display the gradebook.
print("========== SWIFT GRADEBOOK ==========")

for student in students {
    print("\nStudent: \(student.name) (ID: \(student.id))")

    for (subject, marks) in student.marks.sorted(by: { $0.key < $1.key }) {
        print("\(subject): \(marks)")
    }

    if let average = calculateAverage(for: student) {
        print("Average: \(String(format: "%.2f", average))")
    } else {
        print("Average: Not available")
    }
}

// Demonstrate safe optional handling.
print("\n========== OPTIONAL HANDLING ==========")

if let student = findStudent(id: 102) {
    print("Found student: \(student.name)")

    if let marks = getMarks(for: "Swift", student: student) {
        print("Swift marks: \(marks)")
    } else {
        print("Swift marks not available")
    }
} else {
    print("Student not found")
}

// Demonstrate missing student and missing subject.
if let missingStudent = findStudent(id: 999) {
    print(missingStudent.name)
} else {
    print("Student with ID 999 not found.")
}

if let student = findStudent(id: 101),
   let marks = getMarks(for: "Java", student: student) {
    print("Java marks: \(marks)")
} else {
    print("Java marks are not available.")
}
// MARK: - R2: Generic Stack

struct Stack<Element> {
    private var elements: [Element] = []

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    mutating func push(_ element: Element) {
        elements.append(element)
    }

    mutating func pop() -> Element? {
        return elements.popLast()
    }

    func peek() -> Element? {
        return elements.last
    }
}

// Demonstration 1: Stack of Integers
print("\n========== INTEGER STACK ==========")

var numberStack = Stack<Int>()
numberStack.push(10)
numberStack.push(20)
numberStack.push(30)

print("Stack count: \(numberStack.count)")

if let top = numberStack.peek() {
    print("Top element: \(top)")
}

if let removed = numberStack.pop() {
    print("Popped element: \(removed)")
}

// Demonstration 2: Stack of Strings
print("\n========== STRING STACK ==========")

var nameStack = Stack<String>()
nameStack.push("Swift")
nameStack.push("UIKit")
nameStack.push("SwiftUI")

print("Stack count: \(nameStack.count)")

if let top = nameStack.peek() {
    print("Top element: \(top)")
}

if let removed = nameStack.pop() {
    print("Popped element: \(removed)")
}

print("Is string stack empty? \(nameStack.isEmpty)")
// MARK: - R3: Retain Cycle and ARC

class Greeter {
    let name: String
    var greeting: (() -> Void)?

    init(name: String) {
        self.name = name
        print("\(name) created")
    }

    func setupGreeting() {
        // Weak capture prevents a strong reference cycle.
        greeting = { [weak self] in
            guard let self = self else {
                print("Greeter instance no longer exists.")
                return
            }

            print("Hello, \(self.name)!")
        }
    }

    deinit {
        print("\(name) deallocated")
    }
}

// Demonstrate weak capture and automatic deallocation.
print("\n========== RETAIN CYCLE AND ARC ==========")

var greeter: Greeter? = Greeter(name: "Anisha")
greeter?.setupGreeting()

// Keep a reference to the closure independently.
let savedGreeting = greeter?.greeting

savedGreeting?()

// Release the Greeter instance.
greeter = nil

// The closure still exists, but does not retain Greeter.
savedGreeting?()
// MARK: - R4: Error Handling and Validation

enum ValidationError: Error {
    case emptyName
    case invalidAge
}

func validateUser(name: String, age: Int) throws -> String {
    guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
        throw ValidationError.emptyName
    }

    guard age >= 18 && age <= 100 else {
        throw ValidationError.invalidAge
    }

    return "User \(name) is valid. Age: \(age)"
}

print("\n========== ERROR HANDLING ==========")

// Valid input
do {
    let result = try validateUser(name: "Anisha", age: 21)
    print(result)
} catch {
    print("Validation failed: \(error)")
}

// Error 1: Empty name
do {
    let result = try validateUser(name: "", age: 21)
    print(result)
} catch ValidationError.emptyName {
    print("Error: Name cannot be empty.")
} catch ValidationError.invalidAge {
    print("Error: Age must be between 18 and 100.")
} catch {
    print("Unexpected error: \(error)")
}

// Error 2: Invalid age
do {
    let result = try validateUser(name: "Rahul", age: 15)
    print(result)
} catch ValidationError.emptyName {
    print("Error: Name cannot be empty.")
} catch ValidationError.invalidAge {
    print("Error: Age must be between 18 and 100.")
} catch {
    print("Unexpected error: \(error)")
}