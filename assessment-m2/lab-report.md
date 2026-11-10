# Milestone 2: Architecture and Concurrency

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Refactor task list to MVVM and test view-model logic | The SwiftUI screen uses `TaskListViewModel` for task actions and filtering. The core XCTest suite verifies add/trim, blank validation, completion toggle, filtering, and deletion. |
| R2: Fetch two independent sources concurrently | `DashboardService.loadDashboard()` starts course and announcement requests in a task group and combines their typed results. |
| R3: Show loading, success, error, and cancellation | `DashboardViewModel.State` represents each state. The app has an error toggle and an in-flight cancel button. |
| R4: Explain main actor/queue UI updates | See below. |
| R5: Compare GCD, async/await, Task, and task groups | See [viva-notes.md](./viva-notes.md). |

## Why UI updates belong on the main actor

UI frameworks coordinate event handling, layout, and drawing on the main thread. Updating UI state from concurrent background work can race with those operations and result in inconsistent display or runtime diagnostics. `DashboardViewModel` and `TaskListViewModel` are `@MainActor`, so their published state and view-facing mutations are isolated to the main actor. The asynchronous service suspends while work is in progress; the completed result is applied to the view model on the main actor.

## Run and test

The `App/` files are intended for an iOS App target in Xcode on macOS. Add `MilestoneCore` from this folder as a local Swift package dependency, include `AssessmentM2App.swift` in the app target, and run on an iOS 16+ Simulator or device.

Run `swift test` from this folder to execute view-model, concurrent-source, error, and cancellation tests. This workspace runs on Windows without Xcode or the iOS Simulator, so the iOS UI cannot be launched here.
