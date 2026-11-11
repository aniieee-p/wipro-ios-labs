# Lab 7B: UIKit Navigation and View Hierarchy

Open [Lab7B.xcodeproj](./Lab7B.xcodeproj) on macOS and run the Lab7B target on an iOS 16+ simulator or device. The project compiles the shared course model directly into the app target; `Package.swift` provides a separate portable target for model tests. The app builds its UIKit interface programmatically; no storyboard outlets or global selection state are used.

## Navigation

1. `Lab7BAppDelegate` creates a `UINavigationController` whose root is `CourseListViewController`.
2. The table view displays courses with a reusable `CourseTableViewCell`.
3. Selecting a row obtains the corresponding `Course` from the list's own array, constructs `CourseDetailViewController(course:)`, and pushes it on the navigation stack.
4. The navigation bar's Back control pops to the list.

See [navigation-flow.svg](./navigation-flow.svg).

## View hierarchy

```text
UIWindow
└── UINavigationController
    ├── CourseListViewController
    │   └── UITableViewController.view
    │       └── UITableView
    │           └── UITableViewCell
    │               └── contentView
    │                   └── UIStackView
    │                       └── title / instructor / duration labels
    └── CourseDetailViewController (pushed)
        └── UIViewController.view
            └── UIStackView
                └── course title / instructor / duration / summary labels
```

In Xcode, run the app, open **Debug > View Debugging > Capture View Hierarchy**, and inspect the controller and view tree. The list and detail controller views are managed by the navigation controller; pushing and popping changes which stack entry is visible.

## Screenshots

- [Course list preview](./screenshots/course-list-preview.svg)
- [Course detail preview](./screenshots/course-detail-preview.svg)

These are illustrative screen previews, not captures from the iOS Simulator. Capture native screenshots by running the Xcode project on macOS.

Run `swift test` in this folder for the course model tests.
The model test results are recorded in [test-output.md](./test-output.md).
