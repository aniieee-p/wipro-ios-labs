# Lab 8C: State Management

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Use `@State` for local view state | `CourseListView` owns its search query with `@State`; it affects only the list's local filtering UI. |
| R2: Share courses through an observable model | `CourseLibrary` is an `ObservableObject` created once by the app with `@StateObject`. `CourseListView` observes it with `@ObservedObject`; its published favorite collection drives updates. |
| R3: Bind parent-owned state into child views | `CourseListView` creates a `Binding<Bool>` for each course and passes it to `FavoriteToggleButton` and `CourseDetailView`, which edit the parent's shared favorite state. |
| R4: Add/remove favorites and keep screens synchronized | The list row and detail screen use bindings backed by the same `CourseLibrary`. Toggling either view publishes the new state, updating both. |
| R5: Explain local versus shared state | See [State ownership](#state-ownership). |
| Extension: Persist favorites | `CourseLibrary` loads favorite IDs from `UserDefaults` at launch and saves each change, restoring favorites after relaunch. |

## State ownership

- **`@State`** owns `searchText` because it is temporary input used only by the course list. It does not belong in the shared model.
- **`@StateObject`** creates and retains the single `CourseLibrary` instance at the app entry point. The app owns the observable model's lifetime.
- **`@ObservedObject`** lets `CourseListView` observe the model passed in by its owner. The list does not create another model.
- **`@Published`** announces changes to the model's favorite collection so observing views update.
- **`@Binding`** lets reusable child controls and the detail screen edit a favorite value owned by the shared model without copying it.

Keep transient, screen-specific values local. Put data in a shared observable model when multiple screens must read and change the same source of truth. Persist only state that should survive relaunch; this example saves favorite course IDs using `UserDefaults`.

## Run and test

Open [Package.swift](./Package.swift) with Xcode on macOS, add `CourseStateCore` as a local package dependency to an iOS App target, and include the Swift files in `App/` in the app target. Run on an iOS 16+ simulator or device. Run `swift test` in this folder for the favorite ID tests.

This workspace is on Windows without a working Swift toolchain, Xcode, or an iOS Simulator, so native build and UI verification must be run on macOS.
