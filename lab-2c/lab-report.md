

\# Lab 2C: Protocols, Extensions, and Generics



\## R1: Displayable Protocol



Defined a `Displayable` protocol with a `displayText` property. Both `Student` and `Course` conform to the protocol and provide their own display information.



\## R2: String Extension



Extended the existing `String` type with a computed property called `trimmed`. It removes leading and trailing whitespace and newline characters.



\## R3: Generic Stack



Created a generic `Stack<Element>` structure with the following operations:



\- `push(\_:)` adds an element.

\- `pop()` removes and returns the last element.

\- `peek()` returns the top element without removing it.

\- `isEmpty` checks whether the stack contains elements.



Also made Stack conform to a custom `StackOperations` protocol and demonstrated it with both `Int` and `String`.



\## R4: Protocol-Constrained Generic Function



Created `displayItem<T: Displayable>(\_:)`, which accepts only types conforming to `Displayable`.



`Student` and `Course` are valid examples. Passing an `Int` is an invalid use because `Int` does not conform to the protocol. The invalid example is kept commented out to preserve successful compilation.



\## R5: Extensions and Stored State



Extensions can add computed properties, methods, and other functionality to existing types, but they cannot add stored properties.



When a type needs new stored state, its original declaration must be modified or a new type should be created. An extension is therefore not a substitute for a new type.



\## Assertion Tests



Included 10 executable assertion checks covering:



\- Student and Course display output.

\- String trimming.

\- Empty stack behaviour.

\- Stack push, peek, and pop operations.

\- Integer and String generic stack usage.



The program prints a success message when all assertions pass.



\## Conclusion



This lab demonstrates protocol-based abstraction, extensions, generic data structures, protocol constraints, and reusable Swift code without duplicating logic.



