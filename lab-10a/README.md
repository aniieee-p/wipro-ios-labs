# Lab 10A: XCTest Unit Tests

## Test target and coverage

This Swift package defines a `UnitTestPracticeCoreTests` XCTest target, independently of any UI target. It contains **19 named test cases** covering:

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

**Test execution evidence:** This workspace runs on Windows and its Swift command fails to launch. Tests have been authored but were not executed here; no passing test result or screenshot is claimed. The screenshot folder contains instructions, not a fabricated test-run image. Run the tests in a working Swift/Xcode environment before capturing and reporting a passing run.
