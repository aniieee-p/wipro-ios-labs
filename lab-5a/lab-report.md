# Lab 5A: GCD, Queues, and Main-Thread UI

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Simulate slow work without blocking the main thread | The profile and messages responses are independently delayed on a global queue. The delays do not sleep or block the UI thread. |
| R2: Use background and main queues in a UIKit example | `ParallelWorkCoordinator` starts work on `DispatchQueue.global`; `QueueDemoViewController` receives results on `DispatchQueue.main` and updates UIKit there. |
| R3: Simulate a delayed response | Both operations use `DispatchQueue.asyncAfter` with different deadlines. |
| R4: Show loading and prevent duplicate submissions | The controller starts a `UIActivityIndicatorView`, disables the button, and guards against a second submission until results arrive. |
| R5: Identify the executing queue/thread | Console and on-screen event logs label each step with its expected queue and whether it is running on the main thread. See [event-log.md](./event-log.md). |
| Optional: Run independent work concurrently and collect results safely | A `DispatchGroup` joins two operations; an `NSLock` protects their shared result collector. Results are delivered on the main queue in stable name order. |

## Why UI updates belong on the main queue

UIKit view state is coordinated with the app's main run loop, which processes input and draws frames. Mutating UIKit controls from a background queue can race with that work, produce inconsistent or delayed rendering, and trigger Main Thread Checker warnings or crashes. Keep UI changes on the main queue; do background work and then transfer only the finished result back to the main queue.

## Run the app

The `App/` files are intended for an iOS App target in Xcode on macOS. Add `QueueDemoCore` from this folder as a local Swift package dependency, add both files in `App/` to the app target, and run on an iOS Simulator or device. The example uses SwiftUI only to host the UIKit view controller; the screen and all controls are UIKit.

The app requires iOS 16 or later. Open the Xcode console to inspect queue/thread logs and tap **Start work** to observe the loading state and responsive UI.

## Run the core test

Run `swift test` from this folder. The test verifies both independent results are collected and the completion callback runs on the main thread.

This workspace runs on Windows and does not include Xcode, UIKit, or an iOS Simulator. The runnable iOS target must therefore be launched on macOS; the platform-independent coordinator and its tests can be validated here with Swift.
