
import Foundation

// MARK: - R1: Displayable Protocol

protocol Displayable {
    var displayText: String { get }
}

struct Student: Displayable {
    let name: String
    let marks: Int

    var displayText: String {
        return "Student: \(name), Marks: \(marks)"
    }
}

struct Course: Displayable {
    let title: String
    let credits: Int

    var displayText: String {
        return "Course: \(title), Credits: \(credits)"
    }
}

// MARK: - R2: Extension on an Existing Type

extension String {
    // Computed property added through an extension.
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - R3: Generic Stack

struct Stack<Element> {
    private var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        return items.popLast()
    }

    func peek() -> Element? {
        return items.last
    }

    var isEmpty: Bool {
        return items.isEmpty
    }
}

// MARK: - Optional Extension: Custom Protocol for Stack

protocol StackOperations {
    associatedtype Item

    mutating func push(_ item: Item)
    mutating func pop() -> Item?
    func peek() -> Item?
    var isEmpty: Bool { get }
}

extension Stack: StackOperations {}

// MARK: - R4: Protocol-Constrained Generic Function

func displayItem<T: Displayable>(_ item: T) -> String {
    return item.displayText
}

// Student and Course are valid because they conform to Displayable.
let student = Student(name: "Anisha", marks: 90)
let course = Course(title: "Swift Programming", credits: 4)

print("=== R1: Displayable Protocol ===")
print(displayItem(student))
print(displayItem(course))

// Invalid example: Int does not conform to Displayable.
// Uncommenting the following line causes a compile-time error:
// print(displayItem(100))

// MARK: - R5: Why Extensions Cannot Add Stored Properties

/*
Extensions can add computed properties and methods,
but cannot add stored properties to an existing type.

If a type needs new stored state, define a new type
or modify the original type's declaration instead.
*/

// MARK: - Assertion Tests

print("\n=== Lab 2C: Assertion Tests ===")

// Test 1: Student display text
assert(student.displayText == "Student: Anisha, Marks: 90")

// Test 2: Course display text
assert(course.displayText == "Course: Swift Programming, Credits: 4")

// Test 3: String extension trims whitespace
assert("  Swift Lab  ".trimmed == "Swift Lab")

// Test 4: New integer stack is empty
var integerStack = Stack<Int>()
assert(integerStack.isEmpty == true)

// Test 5: Push and peek
integerStack.push(10)
integerStack.push(20)
assert(integerStack.peek() == 20)

// Test 6: Pop returns the last item
assert(integerStack.pop() == 20)

// Test 7: Stack retains the previous item
assert(integerStack.peek() == 10)

// Test 8: Pop the remaining item
assert(integerStack.pop() == 10)
assert(integerStack.isEmpty == true)

// Test 9: Generic stack also works with String
var stringStack = Stack<String>()
stringStack.push("Swift")
stringStack.push("Generics")
assert(stringStack.peek() == "Generics")

// Test 10: String stack pop
assert(stringStack.pop() == "Generics")
assert(stringStack.peek() == "Swift")

print("All 10 assertion tests passed!")

// MARK: - Demonstration

print("\n=== Integer Stack ===")

var numbers = Stack<Int>()
numbers.push(100)
numbers.push(200)
numbers.push(300)

print("Top element: \(numbers.peek() ?? 0)")
print("Removed element: \(numbers.pop() ?? 0)")
print("New top element: \(numbers.peek() ?? 0)")

print("\n=== String Stack ===")

var words = Stack<String>()
words.push("Hello")
words.push("Swift")

print("Top element: \(words.peek() ?? "Empty")")

print("\n=== Lab 2C Completed ===")
