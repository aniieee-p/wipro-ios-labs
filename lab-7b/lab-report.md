# Lab 7B: Storyboards, View Hierarchy, and Navigation

## Requirements

| Requirement | Implementation |
|---|---|
| R1: List and detail screens | `CourseListViewController` and `CourseDetailViewController` are programmatic UIKit screens in the Xcode project. |
| R2: Pass the selected model explicitly | The list creates the detail screen with `CourseDetailViewController(course: selectedCourse)`. The model is held by the destination; no global variable or singleton is involved. |
| R3: Push and pop navigation | A `UINavigationController` owns the list root and pushes the detail screen. The standard Back button pops it. |
| R4: Inspect view hierarchy | [README.md](./README.md) includes the hierarchy and the Xcode View Debugger steps. |
| R5: Avoid force-unwrapped outlets | There are no storyboard outlets. Controllers and cells are initialized programmatically, and required coder initializers fail safely by returning `nil`. |
| Extension: Empty state and reusable cell | `CourseListViewController` displays an empty state when initialized with no courses. `CourseTableViewCell` is reused through `UITableView.CellRegistration`. |

## Screenshots

The [list preview](./screenshots/course-list-preview.svg) and [detail preview](./screenshots/course-detail-preview.svg) are illustrative assets, not simulator screenshots. Native captures and live view-hierarchy inspection require Xcode on macOS.
