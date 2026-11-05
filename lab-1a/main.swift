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
let isPass: Bool = subject1 >= passingMarks &&
                   subject2 >= passingMarks &&
                   subject3 >= passingMarks &&
                   subject4 >= passingMarks &&
                   subject5 >= passingMarks

let result: String = isPass ? "PASS" : "FAIL"

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