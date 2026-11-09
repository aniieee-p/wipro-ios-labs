# Lab 5D: Concurrency Safety

## Before and after

The **before** implementation is `UnsafeCounter`: many concurrent child tasks call `increment()`, which performs an unsynchronized read-modify-write on one shared integer. Two tasks can read the same old value and overwrite each other's increments. The displayed value can be less than the expected total; the exact result varies between runs. This deliberately unsafe version is isolated to the demo.

The **after** implementation is `SafeCounter`, an actor. Its state is private, and each increment or read is an actor-isolated operation. Swift serializes access to that actor's mutable state, so the final count matches the number of requested increments.

## Sendable, in beginner terms

`Sendable` marks a value as safe to transfer between concurrent tasks. Simple value types such as integers and immutable data structs are generally safe to copy between tasks. A normal class is shared by reference, so its mutable properties could be accessed at the same time from different tasks. Avoid sending such shared mutable objects across concurrency boundaries unless access is protected by an actor or another synchronization mechanism.

The intentionally unsafe example uses `@unchecked Sendable` solely to bypass the compiler's safety check and demonstrate the bug. It is not a pattern to copy into production code. The corrected `SafeCounter` is an actor and does not need `@unchecked Sendable`.

## Compiler warnings

The unsafe class is marked `@unchecked Sendable` because the sample intentionally shares it unsafely. This suppresses the compiler's normal warning/error that the non-Sendable mutable class is crossing concurrency boundaries; the annotation is an explicit promise the implementation does not actually uphold. In contrast, the actor-based implementation satisfies the concurrency boundary safely.

No expected Swift concurrency warning should remain for the safe implementation. The compiler cannot diagnose or guarantee the runtime count from this intentionally unchecked example; use the result as an illustration of why compile-time isolation checks matter.

## Tests and app

The repeated test runs the safe counter ten times with 10,000 increments each and asserts every final count is exact. A second test checks the zero-work edge case. Both tests passed on Windows with Swift 6.4.2; see [test-output.md](./test-output.md).

The SwiftUI app is in `App/` and is intended for an iOS App target in Xcode on macOS. Add `ConcurrencySafetyCore` from this folder as a local Swift package dependency, include the two app files in the iOS target, and tap **Run counter experiment**. The unsafe value may or may not visibly lose increments on a particular run; a matching result does not make the implementation race-free. The actor result should always match the expected count.

Run `swift test` from this folder to execute the repeated test. This workspace runs on Windows without Xcode or the iOS Simulator, so the UI cannot be launched here.
