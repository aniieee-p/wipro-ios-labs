
import Foundation

// MARK: - Student Data

let studentMarks: [String: Int] = [
    "S101": 85,
    "S102": 78,
    "S103": 92
]

// MARK: - R1: Optional Return Type

func findMarks(for studentID: String) -> Int? {
    return studentMarks[studentID]
}

print("=== R1: Student Marks Lookup ===")

if let marks = findMarks(for: "S101") {
    print("S101 Marks: \(marks)")
} else {
    print("Student not found.")
}

if let marks = findMarks(for: "S999") {
    print("S999 Marks: \(marks)")
} else {
    print("S999 not found.")
}

// MARK: - R2: Optional Handling

print("\n=== R2: Optional Handling ===")

// if let
if let marks = findMarks(for: "S102") {
    print("if let: Marks = \(marks)")
}

// guard let
func displayMarks(for studentID: String) {
    guard let marks = findMarks(for: studentID) else {
        print("guard let: No marks found for \(studentID)")
        return
    }

    print("guard let: Marks = \(marks)")
}

displayMarks(for: "S103")
displayMarks(for: "S999")

// Optional chaining
struct Student {
    let name: String
    let email: String?
}

let student: Student? = Student(
    name: "Anisha",
    email: "anisha@example.com"
)

let emailLength = student?.email?.count
print("Optional chaining: Email length = \(emailLength ?? 0)")

// Nil-coalescing
let missingMarks = findMarks(for: "S999") ?? 0
print("Nil-coalescing: Missing marks = \(missingMarks)")

// MARK: - R3: Graceful Input Handling

print("\n=== R3: Graceful Error Handling ===")

let unknownID = "S500"

if let marks = studentMarks[unknownID] {
    print("Marks: \(marks)")
} else {
    print("No student record found for \(unknownID).")
}

let textFieldInput = "   "
let cleanedInput = textFieldInput.trimmingCharacters(
    in: .whitespacesAndNewlines
)

if cleanedInput.isEmpty {
    print("Please enter a valid student ID.")
} else {
    print("Entered ID: \(cleanedInput)")
}

// MARK: - R4: Avoid Force Unwrapping

print("\n=== R4: Safe Optional Access ===")

let safeMarks: Int? = studentMarks["S101"]

if let value = safeMarks {
    print("Safely accessed marks: \(value)")
} else {
    print("Marks are unavailable.")
}

// No force unwraps are used.

// MARK: - R5: Optional Profile Properties

print("\n=== R5: Student Profile ===")

struct StudentProfile {
    let name: String
    let address: String?
    let phone: String?
}

let profile = StudentProfile(
    name: "Anisha Patel",
    address: nil,
    phone: nil
)

print("Name: \(profile.name)")
print("Address: \(profile.address ?? "Not provided")")
print("Phone: \(profile.phone ?? "Not provided")")
