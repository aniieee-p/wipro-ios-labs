import Foundation

// R1: Array Operations
print("========== R1: ARRAY OPERATIONS ==========")

var courses = ["Swift", "Python", "Java", "C++"]
print("Original courses: \(courses)")

// Add a course
courses.append("JavaScript")
print("After adding: \(courses)")

// Remove C++ from the array
if let index = courses.firstIndex(of: "C++") {
    courses.remove(at: index)
}
print("After removing C++: \(courses)")

// Sort courses alphabetically
let sortedCourses = courses.sorted()
print("Sorted courses: \(sortedCourses)")

// Filter courses starting with J
var filteredCourses: [String] = []
for course in courses {
    if course.hasPrefix("J") {
        filteredCourses.append(course)
    }
}
print("Courses starting with J: \(filteredCourses)")

// Search for a course
let searchCourse = "Python"
if courses.contains(searchCourse) {
    print("\(searchCourse) is available.")
} else {
    print("\(searchCourse) is not available.")
}

// R2: Set Operations
print("\n========== R2: SET OPERATIONS ==========")

let studentIDs = [101, 102, 103, 101, 104, 102, 105, 103]
let uniqueStudentIDs = Set(studentIDs)

print("Original student IDs: \(studentIDs)")
print("Unique student IDs: \(uniqueStudentIDs.sorted())")
print("Unique student count: \(uniqueStudentIDs.count)")

// R3: Dictionary Operations
print("\n========== R3: DICTIONARY OPERATIONS ==========")

let studentMarks: [Int: Int] = [
    101: 85,
    102: 92,
    103: 67,
    104: 78,
    105: 95
]

print("Student marks: \(studentMarks)")

// Find the highest marks
var topperID = 0
var highestMarks = 0

for (id, marks) in studentMarks {
    if marks > highestMarks {
        highestMarks = marks
        topperID = id
    }
}

print("Topper ID: \(topperID)")
print("Highest marks: \(highestMarks)")

// Find students below threshold
let threshold = 75
print("Students scoring below \(threshold):")

for id in studentMarks.keys.sorted() {
    if let marks = studentMarks[id], marks < threshold {
        print("Student ID: \(id), Marks: \(marks)")
    }
}

// R4: Enum and Switch
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

// Extension: Enum with Associated Values

enum APIResult {
    case success(data: String)
    case failure(message: String)
}

let result1 = APIResult.success(data: "Student list loaded.")
let result2 = APIResult.failure(message: "Server not found.")

print("\n========== EXTENSION: ENUM WITH ASSOCIATED VALUES ==========")

switch result1 {
case .success(let data):
    print("Success: \(data)")
case .failure(let message):
    print("Error: \(message)")
}

switch result2 {
case .success(let data):
    print("Success: \(data)")
case .failure(let message):
    print("Error: \(message)")
}
