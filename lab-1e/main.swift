import Foundation

// MARK: - R1: Struct and Class

struct Course {
    var title: String
    var credits: Int
}

class CourseManager {
    var course: Course

    init(course: Course) {
        self.course = course
    }

    deinit {
        print("CourseManager instance released.")
    }
}

// MARK: - R2: Value and Reference Behaviour

print("=== R1: Course Struct and CourseManager Class ===")

var originalCourse = Course(title: "Swift Programming", credits: 4)
var copiedCourse = originalCourse

copiedCourse.title = "Advanced Swift"
copiedCourse.credits = 5

print("Original course: \(originalCourse.title), Credits: \(originalCourse.credits)")
print("Copied course: \(copiedCourse.title), Credits: \(copiedCourse.credits)")

let manager = CourseManager(course: originalCourse)
let managerAlias = manager

managerAlias.course.title = "iOS Development"

print("Manager course: \(manager.course.title)")
print("Alias course: \(managerAlias.course.title)")

// MARK: - R3: Related Reference Types and ARC

print("\n=== R3: Teacher and Classroom ===")

class Teacher {
    let name: String
    weak var classroom: Classroom?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Teacher \(name) released.")
    }
}

class Classroom {
    let roomNumber: String
    weak var teacher: Teacher?

    init(roomNumber: String) {
        self.roomNumber = roomNumber
    }

    deinit {
        print("Classroom \(roomNumber) released.")
    }
}

var teacher: Teacher? = Teacher(name: "Mr. Sharma")
var classroom: Classroom? = Classroom(roomNumber: "A101")

teacher?.classroom = classroom
classroom?.teacher = teacher

print("Teacher: \(teacher?.name ?? "None")")
print("Classroom: \(classroom?.roomNumber ?? "None")")
print("Both relationships are weak, so they do not create a strong cycle.")

teacher = nil
classroom = nil

// MARK: - R4: Strong Reference Cycle and Weak Capture

print("\n=== R4: Closure Capture and Retain Cycle ===")

class ReportGenerator {
    var onComplete: (() -> Void)?

    func complete() {
        print("Report generation completed.")
    }

    func demonstrateStrongCapture() {
        onComplete = {
            self.complete()
        }
        print("A strong closure capture of self has been created.")
    }

    func demonstrateWeakCapture() {
        onComplete = { [weak self] in
            self?.complete()
        }
        print("The closure now captures self weakly.")
    }

    deinit {
        print("ReportGenerator instance released.")
    }
}

// Demonstrate strong capture and then break the cycle.
var strongGenerator: ReportGenerator? = ReportGenerator()
strongGenerator?.demonstrateStrongCapture()

// The closure retains self, creating a strong reference cycle.
// Clearing the closure breaks the cycle.
strongGenerator?.onComplete = nil
strongGenerator = nil

// Demonstrate the weak capture solution.
var weakGenerator: ReportGenerator? = ReportGenerator()
weakGenerator?.demonstrateWeakCapture()
weakGenerator?.onComplete?()
weakGenerator = nil

// MARK: - R5: Value Semantics, Reference Semantics and ARC

print("\n=== R5: Concepts ===")

print("Structs use value semantics: assigning a struct creates an independent value.")
print("Classes use reference semantics: multiple references can point to the same instance.")
print("ARC tracks strong references to class instances and releases them when no strong references remain.")
print("Weak references do not keep an instance alive.")
print("Value types are not guaranteed to always be stored on the stack; storage depends on context and implementation.")