# Lab 5B: async/await and Task

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Async function simulates fetching courses | `CourseCatalogService.fetchCourses(for:)` awaits several short delays, checking cancellation between them, then returns sample courses, an empty list, or a simulated service error. |
| R2: Call from a Task and update the UI after the result | `CourseLoadingModel.load(scenario:)` creates a `Task`, awaits the service, and publishes the resulting state. The model is `@MainActor`, so observable UI state changes are serialized on the main actor. |
| R3: Represent loading, success, empty, and failure | The model uses separate `State` cases for each, plus idle and cancelled states. Choose Success, Empty, or Failure in the segmented picker to demonstrate each response. |
| R4: Add cancellation and check it | The screen exposes **Cancel request** while loading. It cancels the stored task; the service checks cancellation before each delay and after the simulated work. `CancellationError` becomes a distinct cancelled state. |
| R5: Explain function declaration versus Task creation | See the explanation below. |
| Optional: Throwing function and retry | The fetch function throws a typed service error; the failure screen provides **Retry**. |

## Async function versus Task

Declaring `fetchCourses` as `async` describes work that can suspend and be awaited; the declaration alone does not start a fetch. Calling it requires an asynchronous context and `await`. `Task { ... }` creates and starts an asynchronous unit of work from the button action, giving the app a task handle it can retain and cancel. The model awaits the fetch inside that task and then publishes a UI state on the main actor.

Cancellation is cooperative: cancelling a task requests cancellation, and the task must reach a cancellation-aware operation or explicitly check `Task.checkCancellation()`. Here, the delay is cancellation-aware and the service also checks between simulated steps. The error path catches `CancellationError` separately from an actual service failure.

## Run and test

The `App/` files are intended for an iOS App target in Xcode on macOS. Add `CourseLoadingCore` from this folder as a local Swift package dependency, include the two files in `App/` in the app target, and run on an iOS 16+ Simulator or device. The screen is SwiftUI; the fetch model and service are in the package.

Run `swift test` from this folder to test success, empty, failure, and cancellation behavior in the service. This workspace runs on Windows without Xcode or the iOS Simulator, so the iOS UI cannot be launched here.
