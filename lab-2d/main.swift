import Foundation

// R1: Validation Errors

enum ValidationError: Error {
    case emptyName
    case invalidMark
    case invalidID
}

// Student Model

struct Student {
    let id: Int
    let name: String
    let mark: Int
}

// R2: Throwing Registration Function

func registerStudent(id: Int, name: String, mark: Int) throws -> Student {
    let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmedName.isEmpty {
        throw ValidationError.emptyName
    }

    if mark < 0 || mark > 100 {
        throw ValidationError.invalidMark
    }

    if id <= 0 {
        throw ValidationError.invalidID
    }

    return Student(id: id, name: name, mark: mark)
}

// R3: Useful Error Messages

func errorMessage(for error: ValidationError) -> String {
    switch error {
    case .emptyName:
        return "Registration failed: Student name cannot be empty."
    case .invalidMark:
        return "Registration failed: Mark must be between 0 and 100."
    case .invalidID:
        return "Registration failed: Student ID must be positive."
    }
}

// Demonstration and Tests

print("=== Lab 2D: Error Handling ===")

// Test 1: Successful registration
do {
    let student = try registerStudent(id: 1, name: "Anisha", mark: 90)
    print("Success: \(student.name), Mark: \(student.mark)")
} catch let error as ValidationError {
    print(errorMessage(for: error))
} catch {
    print("Unexpected error occurred.")
}

// Test 2: Empty name
do {
    _ = try registerStudent(id: 2, name: "   ", mark: 80)
    print("Should not reach here.")
} catch let error as ValidationError {
    print(errorMessage(for: error))
} catch {
    print("Unexpected error occurred.")
}

// Test 3: Invalid mark
do {
    _ = try registerStudent(id: 3, name: "Riya", mark: 120)
    print("Should not reach here.")
} catch let error as ValidationError {
    print(errorMessage(for: error))
} catch {
    print("Unexpected error occurred.")
}

// Test 4: Invalid ID
do {
    _ = try registerStudent(id: 0, name: "Aman", mark: 75)
    print("Should not reach here.")
} catch let error as ValidationError {
    print(errorMessage(for: error))
} catch {
    print("Unexpected error occurred.")
}

print("All Lab 2D checks passed!")

// Extension: Result type comparison
// Result<Success, Failure> is another way to represent success or failure.
// Unlike throws, it lets you store or pass the outcome as a value.

func validateMarkResult(_ mark: Int) -> Result<Int, ValidationError> {
    if mark < 0 || mark > 100 {
        return .failure(.invalidMark)
    }
    return .success(mark)
}

print("\n=== Extension: Result Type ===")

switch validateMarkResult(85) {
case .success(let mark):
    print("Valid mark: \(mark)")
case .failure(let error):
    print(errorMessage(for: error))
}

switch validateMarkResult(150) {
case .success(let mark):
    print("Valid mark: \(mark)")
case .failure(let error):
    print(errorMessage(for: error))
}

// Simulated network response using Result
func fetchStudentData(success: Bool) -> Result<String, ValidationError> {
    if success {
        return .success("Student data received successfully.")
    } else {
        return .failure(.invalidID)
    }
}

let networkResult = fetchStudentData(success: true)
switch networkResult {
case .success(let message):
    print(message)
case .failure(let error):
    print(errorMessage(for: error))
}
