

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



1. `push(\_:)` â€” Adds an element to the top of the stack.

2. `pop()` â€” Removes and returns the top element safely using an optional.

3. `peek()` â€” Returns the top element without removing it.

4. `count` â€” Returns the number of stored elements.

5. `isEmpty` â€” Checks whether the stack contains elements.



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

&#x20;   print(self.name)

}

```



The object retains the closure, and the closure retains the object. This prevents ARC from deallocating the instance.



### Solution: Weak Capture



The problem is fixed using `[weak self]`:



```swift

greeting = { [weak self] in

&#x20;   guard let self = self else {

&#x20;       return

&#x20;   }



&#x20;   print(self.name)

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



1. `emptyName` â€” thrown when the user's name is empty or contains only whitespace.

2. `invalidAge` â€” thrown when the age is outside the permitted range of 18â€“100.



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

- Useful for models and independent data.



**Class:**

- A reference type.

- Multiple variables can refer to the same instance.

- Supports inheritance.

- Uses Automatic Reference Counting (ARC) for memory management.

- Supports deinitializers.



**Example:**



```swift

struct Student {

&#x20;   var name: String

}



class Teacher {

&#x20;   var name: String



&#x20;   init(name: String) {

&#x20;       self.name = name

&#x20;   }

}

```



**Interview Answer:**



A struct is a value type, so it is copied when assigned to another variable. A class is a reference type, so multiple variables can point to the same instance. Classes support inheritance and ARC, whereas structs do not support class inheritance.



### 2. Explain Protocol vs Inheritance.



**Protocol:**

- Defines a set of requirements that conforming types must implement.

- Can be adopted by structs, classes and enums.

- A type can conform to multiple protocols.

- Supports abstraction and code flexibility.



**Inheritance:**

- Allows one class to inherit properties and methods from another class.

- Represents an "is-a" relationship.

- Swift classes support single class inheritance.

- Allows subclasses to override inherited methods.



**Example:**



```swift

protocol Printable {

&#x20;   func printDetails()

}



class Person {

&#x20;   var name = "Anisha"

}



class Student: Person, Printable {

&#x20;   func printDetails() {

&#x20;       print(name)

&#x20;   }

}

```



**Interview Answer:**



A protocol defines what a type must do, while inheritance allows a class to reuse and extend another class's implementation. Protocols provide flexibility because structs, classes and enums can conform to them, and a type can adopt multiple protocols.



### 3. Explain map, filter and reduce in Swift.



These are higher-order functions used to process collections.



**map:**

- Transforms every element into a new value.

- Returns a new collection.



```swift

let numbers = [1, 2, 3, 4]

let doubled = numbers.map { $0 * 2 }



print(doubled) // [2, 4, 6, 8]

```



**filter:**

- Selects elements that satisfy a condition.

- Returns a collection containing matching elements.



```swift

let numbers = [1, 2, 3, 4, 5]

let evenNumbers = numbers.filter { $0 % 2 == 0 }



print(evenNumbers) // [2, 4]

```



**reduce:**

- Combines all elements into a single result.

- Uses an initial value and a combining operation.



```swift

let numbers = [1, 2, 3, 4]

let total = numbers.reduce(0) { $0 + $1 }



print(total) // 10

```



**Interview Answer:**



Map transforms each element, filter selects elements based on a condition, and reduce combines all elements into one result. These functions make collection processing concise and readable.



### Conclusion



This milestone covers important Swift foundations, including collections, optionals, generics, memory management, error handling and functional programming concepts. These concepts help in building safe, reusable and maintainable Swift applications.




