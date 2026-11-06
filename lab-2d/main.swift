import Foundation

// MARK: - R1: Validation Errors

enum ValidationError: Error {
    case emptyName
    case invalidMark
    case invalidID
}

// MARK: - Student Model

struct Student {
    let id: Int
    let name: String
    let mark: Int
}

// MARK: - R2: Throwing Registration Function

func registerStudent(id: Int, name: String, mark: Int) throws -> Student {
    guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
        throw ValidationError.emptyName
    }

    guard (0...100).contains(mark) else {
        throw ValidationError.invalidMark
    }

    guard id > 0 else {
        throw ValidationError.invalidID
    }

    return Student(id: id, name: name, mark: mark)
}

// MARK: - R3: Useful Error Messages

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

// MARK: - R4: Optional Return Comparison

func validateMarkOptional(_ mark: Int) -> Int? {
    return (0...100).contains(mark) ? mark : nil
}

// Result-based validation

func validateMarkResult(_ mark: Int) -> Result<Int, ValidationError> {
    guard (0...100).contains(mark) else {
        return .failure(.invalidMark)
    }

    return .success(mark)
}

// MARK: - Optional Network Response Extension

func simulatedNetworkResponse(success: Bool) -> Result<String, ValidationError> {
    if success {
        return .success("Student data received successfully.")
    } else {
        return .failure(.invalidID)
    }
}

// MARK: - Demonstration and Tests

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
    assertionFailure("Expected empty-name validation to fail.")
} catch let error as ValidationError {
    assert(errorMessage(for: error).contains("name"))
    print(errorMessage(for: error))
} catch {
    print("Unexpected error occurred.")
}

// Test 3: Invalid mark
do {
    _ = try registerStudent(id: 3, name: "Riya", mark: 120)
    assertionFailure("Expected invalid-mark validation to fail.")
} catch let error as ValidationError {
    assert(errorMessage(for: error).contains("Mark"))
    print(errorMessage(for: error))
} catch {
    print("Unexpected error occurred.")
}

// Test 4: Invalid ID
do {
    _ = try registerStudent(id: 0, name: "Aman", mark: 75)
    assertionFailure("Expected invalid-ID validation to fail.")
} catch let error as ValidationError {
    assert(errorMessage(for: error).contains("ID"))
    print(errorMessage(for: error))
} catch {
    print("Unexpected error occurred.")
}

// Test 5: Optional return
assert(validateMarkOptional(85) == 85)
assert(validateMarkOptional(150) == nil)
print("Optional validation tests passed.")

// Test 6: Result success and failure
switch validateMarkResult(95) {
case .success(let mark):
    assert(mark == 95)
    print("Result success: Valid mark \(mark)")
case .failure:
    assertionFailure("Expected a valid mark.")
}

switch validateMarkResult(-5) {
case .success:
    assertionFailure("Expected an invalid mark.")
case .failure(let error):
    assert(errorMessage(for: error).contains("Mark"))
    print("Result failure handled safely.")
}

// Test 7: Simulated network response
let networkResult = simulatedNetworkResponse(success: true)

switch networkResult {
case .success(let message):
    print(message)
case .failure(let error):
    print(errorMessage(for: error))
}

print("All Lab 2D checks passed!")