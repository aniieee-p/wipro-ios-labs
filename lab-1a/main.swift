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
print("Result: \(result)")
