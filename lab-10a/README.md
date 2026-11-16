# Lab 10A: XCTest Unit Tests

## Test target and coverage

This Swift package defines a `UnitTestPracticeCoreTests` XCTest target, independently of any UI target. It contains **17 named test cases** covering:

- **Grade calculation:** weighted percentages, perfect and zero scores, letter-grade boundaries, empty input, zero possible points, scores above the maximum, negative scores, non-finite scores, and overflow in aggregated totals.
- **Form validation:** complete and whitespace-padded valid input, whitespace-only names, malformed or whitespace-containing email, and multiple missing fields.
- **View-model operation:** loading sample courses, an empty result, and a service failure through an injected deterministic stub.

The view-model tests do not call a live API. `CourseListViewModel` receives a `CourseService` dependency, and `StubCourseService` returns controlled data or a controlled error.

## Run the tests and capture evidence

From this directory on macOS with Swift installed:

```sh
swift test
```

In Xcode, open the package, select the `UnitTestPracticeCoreTests` test scheme, and run tests with **Product > Test**. Save a screenshot of Xcode's passing test summary in [screenshots/](./screenshots/).

**Test execution evidence:** The tests were run in the Windows Swift environment: **17 tests passed, 0 failures**. The screenshot folder contains instructions for capturing Xcode evidence; no Xcode or iOS Simulator screenshot is claimed.