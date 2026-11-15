# Lab 10B: UI Automation with XCUITest

## App under test

The UI tests exercise the UIKit profile form in [Lab 7A](../lab-7a/Lab7A.xcodeproj/). It provides a real app launch, accessible name/email/course fields, a submit button, and a visible status message.

## Test cases

`UITests/Lab7AProfileFlowUITests.swift` includes:

1. Launch the app, enter a valid name, email, and course, submit, and verify the success message.
2. Submit an empty form and verify validation feedback.
3. Submit an invalid email with the other fields filled and verify that the form reports validation instead of success.

Tests use the app's accessibility identifiers: `profileName`, `profileEmail`, `profileCourse`, `profileSubmit`, and `profileStatus`. The app adds these identifiers in `../lab-7a/App/ProfileFormViewController.swift`.

## Add and run in Xcode

The existing Lab 7A Xcode project has an app target but no UI-test target. On macOS:

1. Open `../lab-7a/Lab7A.xcodeproj` in Xcode.
2. Choose **File > New > Target… > UI Testing Bundle**. Name the target `Lab7AProfileUITests` and set `Lab7A` as its Target Application.
3. Replace the generated UI test file or add `Lab7AProfileFlowUITests.swift` from this folder to the UI-test target. Ensure the file is in that target's membership.
4. Choose the `Lab7AProfileUITests` test scheme and an iOS Simulator destination.
5. Run **Product > Test**. The UI tests wait for elements with `waitForExistence(timeout:)`; they use no fixed sleeps and make no live service calls.
6. Save a genuine screenshot of the passing Xcode test navigator/results in [screenshots/](./screenshots/).

This workspace is on Windows without Xcode, `xcodebuild`, or an iOS Simulator, so the UI tests and screenshot cannot be run/captured here. Do not treat source-code review as evidence of a passing UI run.

## Unit test versus UI test

A **unit test** calls a small unit such as a validator or grade calculator directly, usually with controlled inputs, and checks its output without launching the app or rendering views. A **UI test** launches the built app as a user would, locates accessible controls, types and taps, and verifies visible behavior across UI, app wiring, and state. Unit tests are narrower and faster; UI tests cover integrated user journeys but need an app target and simulator.
