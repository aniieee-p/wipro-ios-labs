# Lab 1E: Classes, Structs, ARC, and Memory

## R1: Struct and Class

Created a `Course` struct to store course details and a `CourseManager` class to manage a course.

## R2: Value and Reference Behaviour

Copied a `Course` value and modified the copy. The original course stayed unchanged because structs use value semantics — the copy is completely independent.

Created a second reference to the same `CourseManager` instance. Changing the course through the second reference also changed the first manager's data, because classes use reference semantics — both variables point to the same object.

## R3: ARC and Related Reference Types

Created `Teacher` and `Classroom` reference types. Used `weak` references for their relationship so neither object retains the other more strongly than necessary. This avoids a strong reference cycle between them.

## R4: Retain Cycle Prevention

Demonstrated a closure that strongly captures `self`, which creates a retain cycle. Broke the cycle by setting the stored closure to `nil`.

Then used `[weak self]` in a closure so the closure does not keep the owning instance alive. The `deinit` output confirms the instance is released correctly.

## R5: Memory Management Concepts

- Structs use value semantics: copying creates an independent value.
- Classes use reference semantics: multiple variables can share one instance.
- ARC keeps track of strong references and releases an object when none remain.
- Weak references let an object be released even if the reference still exists.
- Value types are not guaranteed to always live on the stack; this depends on context and compiler decisions.

## Conclusion

This lab showed the difference between structs and classes, how ARC manages object lifetimes, and how weak references and capture lists prevent retain cycles.
