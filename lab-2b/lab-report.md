

\# Lab 2B: Closures



\## R1: Sorting Students Using a Closure



Used the `sorted` method with a closure to arrange students by marks in descending order. If marks are equal, names are arranged alphabetically.



\## R2: Completion Closure



Created `performOperation(completion:)`, which accepts a completion closure and calls it after a simulated operation.



\## R3: Trailing Closure and Shorthand Arguments



Used trailing-closure syntax with the shorthand argument `$0` to double numbers. Rewrote the same example using an explicit parameter name, `number`.



\## R4: Captured State



Created a counter function that returns a closure. The closure captures the local variable `count` and preserves its updated value between calls.



\## R5: Avoiding Retain Cycles



Created a `TaskManager` class that stores a closure. Used `\[weak self]` to avoid a strong reference cycle between the object and its stored closure. The `deinit` method demonstrates when the object is released.



\## Closure Parameters, Capture, and Lifetime



Closures can accept parameters and return values like functions. They can capture variables from their surrounding scope and preserve captured state for later use. A closure stored by a long-lived object can create a retain cycle if it strongly captures that object. Using `\[weak self]` prevents this strong reference cycle and allows the object to be deallocated when no strong references remain.



\## Conclusion



This lab demonstrates sorting with closures, completion handlers, trailing-closure syntax, shorthand arguments, captured state, and weak references for memory management.





