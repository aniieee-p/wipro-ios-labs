# Lab 8B: Navigation and Basic Template

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Inspect the `@main` entry point and `WindowGroup` | [Lab8BApp.swift](./App/Lab8BApp.swift) is the app entry point and creates the initial `CourseListView` in its `WindowGroup`. |
| R2: Navigate from a list to a detail view | [CourseListView.swift](./App/CourseListView.swift) uses `NavigationStack` with value-based `NavigationLink`s. |
| R3: Pass the selected model to the detail view | A `.course(Course)` route carries the selected model; the destination passes that exact value to `CourseDetailView`. |
| R4: Toolbar action and working back navigation | The list's info toolbar action pushes the About destination. The system back button pops the current route; the Courses toolbar button on a detail screen clears the path to return to the root list. |
| R5: Explain app entry point versus an individual view | See [App entry point and View](#app-entry-point-and-view) below. |
| Extension: Deep-link-like route | The typed route array supports programmatically appending destinations, demonstrated by the About toolbar action. |

## App entry point and View

`Lab8BApp` conforms to `App` and is marked `@main`, so the system starts the application there. Its `WindowGroup` creates the initial scene content and owns the app's window lifecycle. `CourseListView` is an individual `View`: it describes one screen's interface and navigation behavior, but it does not create the application or its windows.

## Navigation flow

1. The app creates `CourseListView` in the initial `WindowGroup`.
2. Tapping a course appends `.course(selectedCourse)` to the `NavigationStack` path.
3. The typed destination receives that route and constructs `CourseDetailView` with the selected `Course`.
4. The system Back button pops one route. The Courses toolbar action clears the path and returns to the list.
5. The info toolbar action appends `.about`, which also returns with the normal Back button.

See [navigation-flow.svg](./navigation-flow.svg), the [course list preview](./screenshots/course-list-preview.svg), and the [course detail preview](./screenshots/course-detail-preview.svg).

## Run and test

Open [Package.swift](./Package.swift) with Xcode on macOS, add `CourseNavigationCore` as a local package dependency to an iOS App target, and include the Swift files in `App/` in the app target. Run on an iOS 16+ simulator or device. Run `swift test` in this folder to test the model and typed routes.

This workspace is on Windows without a working Swift toolchain, Xcode, or an iOS Simulator. The included SVGs are illustrative screen previews, not simulator captures. Capture native list/detail screenshots on macOS for device-rendered visual evidence.
