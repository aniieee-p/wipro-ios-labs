# Lab 7C: UI Controls and View Lifecycle

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Use at least four UIKit controls | The settings screen uses `UITextField`, `UISwitch`, `UISegmentedControl`, `UISlider`, `UIDatePicker`, and `UIButton`. |
| R2: Update a summary panel | Every control sends a value-changed/editing-changed action to `updateSummary()`. The summary is produced by `ControlSelection` and shown in a semantic-color panel. |
| R3: Log all five lifecycle callbacks | Settings and detail controllers log `viewDidLoad`, `viewWillAppear`, `viewDidAppear`, `viewWillDisappear`, and `viewDidDisappear` to the Xcode console. Recent events are also displayed on the settings screen. |
| R4: Explain lifecycle setup and refresh | See below. |
| R5: Check keyboard presentation and dismissal layout | The form is in a `UIScrollView`, constrained to the safe area and `keyboardLayoutGuide`; keyboard-frame notifications adjust content and scroll-indicator insets. Tap outside or press Return to dismiss. Runtime verification requires the iOS Simulator. |
| Extension: Accessibility and contrast | Controls have accessibility labels; summary updates immediately; Dynamic Type and system semantic colors are used. |

## Lifecycle observation

On first launch, settings receives `viewDidLoad` once, followed by `viewWillAppear` and `viewDidAppear`. Selecting **Open lifecycle detail** causes settings `viewWillDisappear`; the detail screen then receives its load/appearance callbacks. Tapping Back makes detail disappear and settings appear again. The settings screen is not recreated, so `viewDidLoad` should not run again; `viewWillAppear` is the appropriate point to refresh state that may have changed while away.

Lifecycle callbacks are logged to the Xcode console and retained in a small in-memory event store. Exact ordering and transition callbacks may differ slightly during interactive navigation; view load is lazy and occurs once per controller instance.

## What belongs in `viewDidLoad` vs. `viewWillAppear`

`viewDidLoad` is for one-time view construction: create controls, configure targets, establish constraints, and register notifications. It may run long before the screen is visible, but runs once for that controller's loaded view. `viewWillAppear` runs every time the screen is about to become visible and is appropriate for refreshing visible state, such as a summary or data that may have changed on another screen. Avoid rebuilding the hierarchy or repeating one-time observer registration on every appearance.

## Run and test

Open [Lab7C.xcodeproj](./Lab7C.xcodeproj) on macOS and run on an iOS 16+ simulator. Type a name, toggle notifications, change study mode, move the slider, and adjust reminder time; the summary should reflect each change. Focus the name field, scroll while the keyboard is visible, then tap outside or press Return to dismiss.

The app and simulator are unavailable in this Windows workspace, so keyboard behavior and actual lifecycle event ordering have not been observed on-device. The portable summary logic has XCTest coverage; both tests passed with Swift 6.4.2 on Windows. See [test-output.md](./test-output.md).
