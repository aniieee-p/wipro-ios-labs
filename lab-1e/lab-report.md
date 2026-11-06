\# Lab 1E: Classes, Structs, ARC, and Memory



\## R1: Struct and Class



Created a `Course` struct to store course details and a `CourseManager` class to manage a course.



\## R2: Value and Reference Behaviour



Copied a `Course` value and modified the copy. The original course remained unchanged because structs use value semantics.



Created another reference to the same `CourseManager` instance. Changing the course through the second reference also changed the original manager's data because classes use reference semantics.



\## R3: ARC and Related Reference Types



Created `Teacher` and `Classroom` reference types. Used weak references for their relationships so neither object unnecessarily retains the other. This avoids a strong reference cycle.



\## R4: Retain Cycle Prevention



Demonstrated how a closure that strongly captures `self` can create a retain cycle. Broke the cycle by clearing the stored closure.



Then used `\[weak self]` in a closure to prevent it from strongly retaining the owning instance.



\## R5: Memory Management Concepts



\- Structs provide value semantics.

\- Classes provide reference semantics.

\- ARC manages the lifetime of class instances through strong references.

\- Weak references do not keep objects alive.

\- Value types are not necessarily always stored on the stack; their storage depends on context and compiler implementation.



\## Conclusion



This lab demonstrated the differences between structs and classes, reference relationships, ARC memory management, and how weak references and closure capture lists help prevent retain cycles.

