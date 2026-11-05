import Foundation

// MARK: - Student Details

let studentName: String = "Anisha Patel"
let rollNumber: String = "06"

// MARK: - Subject Marks

let subject1: Int = 85
let subject2: Int = 78
let subject3: Int = 90
let subject4: Int = 82
let subject5: Int = 88

// MARK: - Attendance

let attendancePercentage: Double = 92.5

// MARK: - R2: Calculate Total, Average, Percentage and Result

let totalSubjects: Int = 5
let maximumMarks: Int = totalSubjects * 100
let passingMarks: Int = 35

// Calculate Total
let totalMarks: Int = subject1 + subject2 + subject3 + subject4 + subject5

// Calculate Average
let averageMarks: Double = Double(totalMarks) / Double(totalSubjects)

// Calculate Percentage
let percentage: Double = (Double(totalMarks) / Double(maximumMarks)) * 100

// Check Pass or Fail
let isPass: Bool = [
    subject1, subject2, subject3, subject4, subject5
].allSatisfy { isValidMark($0) && $0 >= passingMarks }

// MARK: - R4: If-Else and Switch Statements

// 1. If-Else Statement for Pass/Fail
var finalResult: String

if isPass {
    finalResult = "PASS"
} else {
    finalResult = "FAIL"
}

// 2. Switch Statement for Grade Assignment
let grade: String

if !isPass {
    grade = "F"
} else {
    switch percentage {
    case 90...100:
        grade = "A+"
    case 80..<90:
        grade = "A"
    case 70..<80:
        grade = "B"
    case 60..<70:
        grade = "C"
    case 50..<60:
        grade = "D"
    default:
        grade = "F"
    }
}

// MARK: - R5: Boundary Value Validation

// Function to validate subject marks
func isValidMark(_ mark: Int) -> Bool {
    return mark >= 0 && mark <= 100
}

// Function to validate attendance
func isValidAttendance(_ attendance: Double) -> Bool {
    return attendance.isFinite && (0.0...100.0).contains(attendance)
}
// Validate actual student data
let allMarksValid: Bool = [
    subject1, subject2, subject3, subject4, subject5
].allSatisfy { isValidMark($0) }

let attendanceValid: Bool = isValidAttendance(attendancePercentage)

print("\n========== STUDENT DATA VALIDATION ==========")
print("All Subject Marks Valid: \(allMarksValid)")
print("Attendance Valid: \(attendanceValid)")

// Test 1: Minimum marks (0)
let minimumMark: Int = 0
print("\nMinimum mark (0): \(isValidMark(minimumMark) ? "Valid" : "Invalid")")

// Test 2: Maximum marks (100)
let maximumMark: Int = 100
print("Maximum mark (100): \(isValidMark(maximumMark) ? "Valid" : "Invalid")")

// Test 3: Failing marks (30)
let failingMark: Int = 30
let failingMarkResult: String = isValidMark(failingMark) && failingMark < passingMarks
    ? "Valid mark, but FAIL"
    : "Invalid or passing mark"
print("Failing mark (30): \(failingMarkResult)")

// Test 4: Invalid marks (105)
let invalidMark: Int = 105
print("Invalid mark (105): \(isValidMark(invalidMark) ? "Valid" : "Invalid")")

// Test 5: Invalid attendance (105%)
let invalidAttendance: Double = 105.0
print("Invalid attendance (105%): \(isValidAttendance(invalidAttendance) ? "Valid" : "Invalid")")

// Test 6: Minimum attendance (0%)
let minimumAttendance: Double = 0.0
print("Minimum attendance (0%): \(isValidAttendance(minimumAttendance) ? "Valid" : "Invalid")")

// Test 7: Maximum attendance (100%)
let maximumAttendance: Double = 100.0
print("Maximum attendance (100%): \(isValidAttendance(maximumAttendance) ? "Valid" : "Invalid")")

// Test 8: Negative marks
let negativeMark: Int = -5
print("Negative mark (-5): \(isValidMark(negativeMark) ? "Valid" : "Invalid")")
// MARK: - R3: Swift Operators

// 1. Arithmetic Operators
print("\n========== ARITHMETIC OPERATORS ==========")

let firstNumber: Int = 20
let secondNumber: Int = 5

print("Addition: \(firstNumber + secondNumber)")
print("Subtraction: \(firstNumber - secondNumber)")
print("Multiplication: \(firstNumber * secondNumber)")
print("Division: \(firstNumber / secondNumber)")
print("Remainder: \(firstNumber % secondNumber)")


// 2. Comparison Operators
print("\n========== COMPARISON OPERATORS ==========")

print("Equal: \(firstNumber == secondNumber)")
print("Not Equal: \(firstNumber != secondNumber)")
print("Greater Than: \(firstNumber > secondNumber)")
print("Less Than: \(firstNumber < secondNumber)")
print("Greater Than or Equal: \(firstNumber >= secondNumber)")
print("Less Than or Equal: \(firstNumber <= secondNumber)")


// 3. Logical Operators
print("\n========== LOGICAL OPERATORS ==========")

let hasPassed: Bool = true
let attendanceEligible: Bool = attendancePercentage >= 75

print("AND (&&): \(hasPassed && attendanceEligible)")
print("OR (||): \(hasPassed || attendanceEligible)")
print("NOT (!): \(!hasPassed)")


// 4. Compound Assignment Operators
print("\n========== COMPOUND ASSIGNMENT OPERATORS ==========")

var score: Int = 50

score += 10
print("After += 10: \(score)")

score -= 5
print("After -= 5: \(score)")

score *= 2
print("After *= 2: \(score)")

score /= 5
print("After /= 5: \(score)")


// 5. Nil-Coalescing Operator
print("\n========== NIL-COALESCING OPERATOR ==========")

let optionalName: String? = nil
let displayName: String = optionalName ?? "Unknown Student"

print("Student Name: \(displayName)")


// MARK: - Display Student Details

print("========== STUDENT DETAILS ==========")

print("Student Name: \(studentName)")
print("Roll Number: \(rollNumber)")

print("\nSubject Marks:")
print("Subject 1: \(subject1)")
print("Subject 2: \(subject2)")
print("Subject 3: \(subject3)")
print("Subject 4: \(subject4)")
print("Subject 5: \(subject5)")

print("Attendance: \(attendancePercentage)%")

print("======================================")

// Display Calculated Results
print("\n========== ACADEMIC RESULT ==========")
print("Total Marks: \(totalMarks) / \(maximumMarks)")
print("Average Marks: \(averageMarks)")
print("Percentage: \(percentage)%")
// R4: Formatted Academic Result
print("Pass/Fail Status: \(finalResult)")
print("Grade: \(grade)")