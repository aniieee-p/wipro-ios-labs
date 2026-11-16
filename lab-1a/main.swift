import Foundation

// Student details
let studentName: String = "Anisha Patel"
let rollNumber: String = "06"

// Subject marks
let subject1: Int = 85
let subject2: Int = 78
let subject3: Int = 90
let subject4: Int = 82
let subject5: Int = 88

// Attendance
let attendancePercentage: Double = 92.5

// Passing mark
let passingMarks: Int = 35

// Calculate total and average
let totalMarks: Int = subject1 + subject2 + subject3 + subject4 + subject5
let maximumMarks: Int = 500
let averageMarks: Double = Double(totalMarks) / 5.0
let percentage: Double = (Double(totalMarks) / Double(maximumMarks)) * 100

// Check if student passed all subjects
var isPass: Bool = true
if subject1 < passingMarks || subject2 < passingMarks || subject3 < passingMarks ||
   subject4 < passingMarks || subject5 < passingMarks {
    isPass = false
}

// Decide final result
var finalResult: String
if isPass {
    finalResult = "PASS"
} else {
    finalResult = "FAIL"
}

// Assign grade using switch
var grade: String

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

// Display student details
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

// Display academic result
print("\n========== ACADEMIC RESULT ==========")
print("Total Marks: \(totalMarks) / \(maximumMarks)")
print("Average Marks: \(averageMarks)")
print("Percentage: \(percentage)%")
print("Pass/Fail Status: \(finalResult)")
print("Grade: \(grade)")

// Mark validation function
func isValidMark(_ mark: Int) -> Bool {
    return mark >= 0 && mark <= 100
}

// Attendance validation function
func isValidAttendance(_ attendance: Double) -> Bool {
    return attendance >= 0.0 && attendance <= 100.0
}

// Validate student data
let allMarksValid: Bool = isValidMark(subject1) && isValidMark(subject2) &&
                          isValidMark(subject3) && isValidMark(subject4) &&
                          isValidMark(subject5)
let attendanceValid: Bool = isValidAttendance(attendancePercentage)

print("\n========== DATA VALIDATION ==========")
print("All Subject Marks Valid: \(allMarksValid)")
print("Attendance Valid: \(attendanceValid)")

// Boundary value tests
print("Minimum mark (0): \(isValidMark(0) ? "Valid" : "Invalid")")
print("Maximum mark (100): \(isValidMark(100) ? "Valid" : "Invalid")")
print("Failing mark (30): Valid mark, but FAIL")
print("Invalid mark (105): \(isValidMark(105) ? "Valid" : "Invalid")")
print("Invalid attendance (105%): \(isValidAttendance(105.0) ? "Valid" : "Invalid")")
print("Minimum attendance (0%): \(isValidAttendance(0.0) ? "Valid" : "Invalid")")
print("Maximum attendance (100%): \(isValidAttendance(100.0) ? "Valid" : "Invalid")")
print("Negative mark (-5): \(isValidMark(-5) ? "Valid" : "Invalid")")

// Arithmetic operators
print("\n========== ARITHMETIC OPERATORS ==========")
let firstNumber: Int = 20
let secondNumber: Int = 5

print("Addition: \(firstNumber + secondNumber)")
print("Subtraction: \(firstNumber - secondNumber)")
print("Multiplication: \(firstNumber * secondNumber)")
print("Division: \(firstNumber / secondNumber)")
print("Remainder: \(firstNumber % secondNumber)")

// Comparison operators
print("\n========== COMPARISON OPERATORS ==========")
print("Equal: \(firstNumber == secondNumber)")
print("Not Equal: \(firstNumber != secondNumber)")
print("Greater Than: \(firstNumber > secondNumber)")
print("Less Than: \(firstNumber < secondNumber)")
print("Greater Than or Equal: \(firstNumber >= secondNumber)")
print("Less Than or Equal: \(firstNumber <= secondNumber)")

// Logical operators
print("\n========== LOGICAL OPERATORS ==========")
let hasPassed: Bool = true
let attendanceEligible: Bool = attendancePercentage >= 75

print("AND (&&): \(hasPassed && attendanceEligible)")
print("OR (||): \(hasPassed || attendanceEligible)")
print("NOT (!): \(!hasPassed)")

// Compound assignment operators
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

// Nil-coalescing operator
print("\n========== NIL-COALESCING OPERATOR ==========")
let optionalName: String? = nil
let displayName: String = optionalName ?? "Unknown Student"
print("Student Name: \(displayName)")
