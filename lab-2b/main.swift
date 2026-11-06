
import Foundation

// MARK: - R1: Sorting Students Using a Closure

struct Student {
    let name: String
    let marks: Int
}

let students = [
    Student(name: "Riya", marks: 85),
    Student(name: "Aman", marks: 92),
    Student(name: "Neha", marks: 85),
    Student(name: "Karan", marks: 78)
]

// The closure receives two Student values as parameters.
// It sorts marks in descending order and names alphabetically for ties.
let sortedStudents = students.sorted { firstStudent, secondStudent in
    if firstStudent.marks != secondStudent.marks {
        return firstStudent.marks > secondStudent.marks
    }
    return firstStudent.name < secondStudent.name
}

print("=== R1: Sorted Students ===")
for student in sortedStudents {
    print("\(student.name): \(student.marks)")
}

// MARK: - R2: Completion Closure

func performOperation(completion: (String) -> Void) {
    print("\nOperation started...")

    // Simulated operation
    let result = "Operation completed successfully"

    // Calling the completion closure after the operation.
    completion(result)
}

print("\n=== R2: Completion Closure ===")

performOperation { message in
    print("Completion message: \(message)")
}

// MARK: - R3: Trailing Closure and Shorthand Arguments

let numbers = [1, 2, 3, 4, 5]

// Trailing closure syntax with shorthand argument $0.
let doubledNumbers = numbers.map {
    $0 * 2
}

print("\n=== R3: Trailing Closure ===")
print("Original numbers: \(numbers)")
print("Doubled numbers: \(doubledNumbers)")

// The same example rewritten with an explicit parameter name.
let explicitlyDoubledNumbers = numbers.map { number in
    number * 2
}

print("Explicit parameter result: \(explicitlyDoubledNumbers)")

// MARK: - R4: Counter Closure and Captured State

func createCounter() -> () -> Int {
    var count = 0

    // The returned closure captures the local variable count.
    // Its value remains available between closure calls.
    let counter = {
        count += 1
        return count
    }

    return counter
}

print("\n=== R4: Counter Closure ===")

let counter = createCounter()

print("First call: \(counter())")
print("Second call: \(counter())")
print("Third call: \(counter())")

// MARK: - R5: Avoiding Retain Cycles

class TaskManager {
    var completion: (() -> Void)?

    func startTask() {
        // [weak self] prevents the closure from strongly retaining self.
        completion = { [weak self] in
            guard let self = self else {
                print("TaskManager no longer exists.")
                return
            }

            print("Task completed for \(self.name)")
        }
    }

    let name: String

    init(name: String) {
        self.name = name
        print("\(name) initialized")
    }

    deinit {
        print("\(name) deinitialized")
    }
}

print("\n=== R5: Weak Capture ===")

var manager: TaskManager? = TaskManager(name: "Lab Manager")

manager?.startTask()
manager?.completion?()

// Releasing the object allows deinitialization because the closure
// captures self weakly instead of creating a strong reference cycle.
manager = nil

print("\n=== Lab 2B Completed ===")
