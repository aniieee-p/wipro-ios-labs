# Course Planner

## Problem and users

Students may choose courses without noticing timetable conflicts or credit-load limits. Course Planner is an offline iOS learning project that helps students explore a small course catalog, build a weekly plan, and check scheduling constraints.

## Features

- Home dashboard with planned and remaining credit summaries.
- Searchable course catalog by title, instructor, or category.
- Course details showing instructor, credits, schedule, and description.
- Add and remove courses from the plan.
- Validation for duplicate courses, overlapping meeting times, and the 18-credit limit.
- Classes that end exactly when another begins are allowed.
- Weekly schedule grouped by weekday, with swipe-to-remove support.
- Local sample catalog with no API credentials or network dependency.
- Accessible navigation and controls, error feedback, and loading and empty states.

## Architecture

- `CoursePlannerCore` is a Foundation-only Swift package containing the `Course` model, `CourseCatalogService`, local sample implementation, and `CoursePlannerModel`.
- `CoursePlannerViewModel` loads the catalog and exposes planner, search, and feedback state to the SwiftUI screens.
- SwiftUI views observe one shared view model owned by the app.
- Navigation connects the home, catalog, detail, and weekly schedule screens.

See [architecture.svg](./architecture.svg) for the module and data-flow diagram.

## Setup and run

The iOS app requires macOS and Xcode. To run it:

1. Open Xcode and create a new iOS App project using SwiftUI with an iOS 16 deployment target inside the `capstone/` folder, or add the existing sources to an iOS app target.
2. Add the local `CoursePlannerCore` package from this folder to the app target.
3. Add the Swift files from `App/` to the app target.
4. Ensure `CoursePlannerApp.swift` is the only `@main` app entry point in that target.
5. Select an iOS Simulator and run the app.
6. To run the business-logic tests, open a terminal in this folder and execute `swift test`.

No API keys, credentials, signing certificates, or private keys are required in the source code.

## Screenshots and short demo

The [screenshots](./screenshots/) are illustrative SVG previews, not native captures from a running app.

The [demo script](./demo-script.md) describes a 2–4 minute walkthrough. Capture genuine simulator screenshots and record the actual demo on macOS after running the app. Do not present the SVG previews as simulator evidence.

## Tests and evidence

`Tests/CoursePlannerCoreTests/` contains 15 unit tests covering:

- Credit totals and credit limits.
- Duplicate and unknown courses.
- Schedule conflicts and non-overlapping boundaries.
- Course removal.
- Search and sorting.
- Stale selections.
- The injected local catalog service.

Run the tests from this folder:

```bash
swift test
```

**Test result: 15 tests passed, 0 failures** on the Windows Swift environment.

iOS UI compilation, simulator behavior, accessibility inspection, and native screenshots still require macOS and Xcode verification.

## Limitations

- The catalog uses a small in-memory sample and resets when the app restarts.
- There is no persistence, authentication, server, or enrollment integration.
- Meeting times use weekdays and local minutes, not calendars or time zones.
- The sample model does not include an editor for invalid catalog schedules.
- Full UI and simulator verification still require macOS and Xcode.