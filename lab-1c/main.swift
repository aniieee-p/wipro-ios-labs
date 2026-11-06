
import Foundation

// MARK: - R1: Array Operations

print("========== R1: ARRAY OPERATIONS ==========")

var courses = ["Swift", "Python", "Java", "C++"]

print("Original courses: \(courses)")

// Add a course
courses.append("JavaScript")
print("After adding: \(courses)")

// Remove a course
courses.removeAll { $0 == "C++" }
print("After removing C++: \(courses)")

// Sort courses alphabetically
let sortedCourses = courses.sorted()
print("Sorted courses: \(sortedCourses)")

// Filter courses starting with J
let filteredCourses = courses.filter { $0.hasPrefix("J") }
print("Courses starting with J: \(filteredCourses)")

// Search for a course
let searchCourse = "Python"
if courses.contains(searchCourse) {
    print("\(searchCourse) is available.")
} else {
    print("\(searchCourse) is not available.")
}

// MARK: - R2: Set Operations

print("\n========== R2: SET OPERATIONS ==========")

let studentIDs = [101, 102, 103, 101, 104, 102, 105, 103]
let uniqueStudentIDs = Set(studentIDs)

print("Original student IDs: \(studentIDs)")
print("Unique student IDs: \(uniqueStudentIDs.sorted())")
print("Unique student count: \(uniqueStudentIDs.count)")

// MARK: - R3: Dictionary Operations

print("\n========== R3: DICTIONARY OPERATIONS ==========")

let studentMarks: [Int: Int] = [
    101: 85,
    102: 92,
    103: 67,
    104: 78,
    105: 95
]

print("Student marks: \(studentMarks)")

if let topper = studentMarks.max(by: { $0.value < $1.value }) {
    print("Topper ID: \(topper.key)")
    print("Highest marks: \(topper.value)")
}

let threshold = 75
let belowThreshold = studentMarks
    .filter { $0.value < threshold }
    .sorted { $0.key < $1.key }

print("Students scoring below \(threshold):")

for (studentID, marks) in belowThreshold {
    print("Student ID: \(studentID), Marks: \(marks)")
}

// MARK: - R4: Enum and Switch

print("\n========== R4: ENUM AND SWITCH ==========")

enum TaskPriority {
    case low
    case medium
    case high
    case urgent
}

func priorityLabel(for priority: TaskPriority) -> String {
    switch priority {
    case .low:
        return "Low Priority - Can be completed later."
    case .medium:
        return "Medium Priority - Complete on schedule."
    case .high:
        return "High Priority - Complete soon."
    case .urgent:
        return "Urgent - Requires immediate attention."
    }
}

let tasks: [TaskPriority] = [.low, .medium, .high, .urgent]

for task in tasks {
    print(priorityLabel(for: task))
}
