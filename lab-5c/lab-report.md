# Lab 5C: Task Groups and Structured Concurrency

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Fetch 3–5 course details independently | `CourseDetailsService` simulates four independent course-ID fetches using a configurable `Task.sleep` delay. |
| R2: Use a task group and gather results | `fetchConcurrently(ids:)` adds one child task per ID to `withThrowingTaskGroup`, gathers all outcomes, and sorts them by ID for stable presentation. |
| R3: Compare sequential and concurrent timing | `fetchSequentially(ids:)` and `fetchConcurrently(ids:)` use the same service and simulated delay and measure elapsed time with `ContinuousClock`. The app displays both measurements; see [timing-notes.md](./timing-notes.md). |
| R4: Define behavior for a failed child | The demo uses a partial-results policy. A child converts an ordinary fetch error into a failure outcome, so other results are retained. Cancellation is rethrown, not disguised as a fetch failure. |
| R5: Document cancellation and task lifetime | The comparison task owns the task group and awaits its children before returning. Cancelling the comparison task propagates to child tasks; `Task.sleep` and `Task.checkCancellation()` cooperate with cancellation. See below. |

## Cancellation and structured lifetime

The SwiftUI model retains the comparison `Task` so the user can cancel it. The group’s child tasks cannot outlive the structured task-group scope: the group waits for its children before that scope exits. Cancellation is cooperative; sleeping child tasks throw `CancellationError`, and the service rethrows it rather than returning a normal failed-course result. The UI reports that the comparison was cancelled.

Ordinary errors are handled per request, so one course failure does not cancel successful or still-running siblings. This is intentional for a catalog where partial results are useful. A real application could instead choose all-or-nothing behavior if partial data would be misleading.

## Run and test

The `App/` files are intended for an iOS App target in Xcode on macOS. Add `CourseDetailsCore` from this folder as a local Swift package dependency, include the two files in `App/` in the app target, and run on an iOS 16+ Simulator or device.

Run `swift test` from this folder for the task-group, stable-order, partial-failure, timing, and cancellation tests. The four core tests passed on Windows with Swift 6.4.2; see [test-output.md](./test-output.md). This workspace runs without Xcode or the iOS Simulator, so the iOS UI and actual simulator timing cannot be captured here.
