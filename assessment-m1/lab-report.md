# Milestone 1: Swift Foundations

## R1: Gradebook Using Arrays, Dictionaries and Safe Optionals

### Objective

Build a gradebook that stores student information, subject marks and calculates averages safely.

### Implementation

1. **Arrays:** An array stores multiple Student records. New students can be added using `append()`.
2. **Dictionaries:** Each student stores subject names and marks as key-value pairs.
3. **Optionals:** Student lookup, subject marks and average calculations return optional values.
4. **Safe unwrapping:** `if let` and `guard` prevent unsafe access to missing data.
5. **Higher-order functions:** `first`, `sorted` and `reduce` are used to search, organize and calculate marks.

### Testing

- Displayed all students and their subject marks.
- Calculated the average marks for each student.
- Successfully searched for an existing student.
- Handled a student ID that does not exist.
- Handled a subject that has no recorded marks.

### Conclusion

The gradebook demonstrates how Swift arrays and dictionaries organize data and how optionals make data access safe without force unwrapping.

---

## R2: Generic Stack

### Objective

Create a reusable Stack data structure using Swift generics and demonstrate it with two different element types.

### Implementation

Created `Stack<Element>` with the following operations:

1. `push(_:)` — Adds an element to the top of the stack.
2. `pop()` — Removes and returns the top element safely using an optional.
3. `peek()` — Returns the top element without removing it.
4. `count` — Returns the number of stored elements.
5. `isEmpty` — Checks whether the stack contains elements.

### Demonstration

- `Stack<Int>` stores integer values such as 10, 20 and 30.
- `Stack<String>` stores strings such as Swift, UIKit and SwiftUI.
- Both stacks demonstrate pushing, popping and peeking.
- Optional binding safely handles the returned values.

### Conclusion

Generics allow one Stack implementation to work with different data types while maintaining type safety and avoiding duplicate code.

---

## R3: Retain Cycle and ARC

### Objective

Understand Automatic Reference Counting (ARC), identify a retain cycle and fix it using a weak reference.

### Problem: Strong Reference Cycle

A retain cycle can occur when an object strongly retains a closure and that closure strongly captures the same object.

Example of problematic code:

```swift
greeting = {
    print(self.name)
}
```

The object retains the closure, and the closure retains the object. This prevents ARC from deallocating the instance.

### Solution: Weak Capture

The problem is fixed using `[weak self]`:

```swift
greeting = { [weak self] in
    guard let self = self else {
        return
    }

    print(self.name)
}
```

### Explanation

- ARC manages memory by tracking strong references to class instances.
- A strong reference cycle prevents the reference count from reaching zero.
- `[weak self]` does not keep the instance alive.
- A weak reference becomes `nil` when the instance is deallocated.
- `guard let self` safely unwraps the weak reference.

### Demonstration

The Greeter example stores a closure, invokes it, and then releases the Greeter instance. The `deinit` message demonstrates that the instance is deallocated even though the saved closure still exists.

### Conclusion

Weak capture prevents closure-based retain cycles and allows ARC to release unused class instances.

---

## R4: Throwing Validation Function

### Objective

Create a throwing function that validates user input and handles two different errors.

### Implementation

Created a custom `ValidationError` enum with two cases:

1. `emptyName` — thrown when the user's name is empty or contains only whitespace.
2. `invalidAge` — thrown when the age is outside the permitted range of 18–100.

The `validateUser(name:age:)` function uses `throws` and `throw` to report validation failures.

### Error Handling

The function is called using `try` inside `do-catch` blocks.

Three scenarios are demonstrated:

- Valid name and age: returns a success message.
- Empty name: catches `ValidationError.emptyName`.
- Invalid age: catches `ValidationError.invalidAge`.

### Conclusion

Swift error handling allows functions to report failures clearly. Custom errors and separate catch clauses make validation easier to understand and maintain.

---

## R5: Viva Questions and Answers

### 1. Explain the difference between Struct and Class in Swift.

**Struct:**

- A value type.
- Each variable receives its own copy of the value.
- Does not support inheritance.
- Supports properties, methods, initializers and protocol conformance.
- Useful for