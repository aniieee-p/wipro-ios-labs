# Lab 4B: App, Scene, and View Lifecycles

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Log app and scene lifecycle events | `LifecycleAppDelegate` logs UIKit app launch, active/inactive, foreground/background, and best-effort termination callbacks. The SwiftUI `scenePhase` observer logs scene active, inactive, and background transitions. |
| R2: Log view appearance and disappearance | `HomeView` and `DetailView` log `onAppear` and `onDisappear` events through the shared lifecycle logger. |
| R3: Navigate between two screens | The Home screen links to Details in a `NavigationStack`; the navigation bar returns to Home. See the representative sequence in [event-log.md](./event-log.md). |
| R4: Refresh at an appropriate lifecycle point | `DetailView.onAppear` updates a display timestamp and refresh counter. This lightweight, repeatable refresh belongs at appearance because the detail content should be current whenever the screen is shown. Network loading, long-running work, and unrelated setup do not belong in this callback. |
| R5: Document repeated appearance | Popping Details reveals Home again and triggers Home's `onAppear`. Opening Details again triggers its `onAppear` and refresh again. Appearance callbacks are repeatable, not one-time initialization. |

## Event logging and responsibility

`LifecycleLogger` records each event to the Xcode console and publishes it for the Home screen's recent-events list. App-level events are observed through `UIApplicationDelegate` and scene-level transitions through SwiftUI's `scenePhase`. These are related lifecycle signals, not interchangeable callbacks, and exact ordering can vary.

`onAppear` can run repeatedly as navigation and scene presentation changes. The example uses it only for a small idempotent display refresh; persistent setup should be managed separately. `applicationWillTerminate` is best effort and is not a safe place for essential saves.

## Two-screen UI previews

The files in `screenshots/` are illustrative screen mockups, not captures from a running iOS Simulator. This workspace runs on Windows and does not provide UIKit, SwiftUI, or the iOS Simulator. Capture native screenshots by running the app on an iOS Simulator or device from Xcode on macOS.

## Run the testable event-log core

Run `swift test` from this directory. The XCTest target verifies that lifecycle events are stored in order with their timestamps. The app sources in `App/` are intended for an iOS SwiftUI App target in Xcode and cannot be launched on this Windows host.
