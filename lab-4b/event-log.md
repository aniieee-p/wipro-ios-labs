# Lab 4B event log

This is a representative event sequence for a SwiftUI app using a `WindowGroup` and a `NavigationStack`. Exact ordering can vary by iOS version, device state, and navigation transition. At runtime, the app prints timestamped events to the Xcode console and displays the most recent events on the Home screen.

## Launch and navigate to Details

```text
App: SwiftUI App initialized
AppDelegate: didFinishLaunching
App: didBecomeActive
Scene: active
View: Home onAppear
View: Home onDisappear
Refresh: Detail timestamp updated
View: Detail onAppear
```

## Navigate back to Home

```text
View: Detail onDisappear
View: Home onAppear
```

The detail view can appear again on a later navigation, so its lightweight refresh runs again. View appearance is not a one-time initialization callback.

## Background and foreground the app

```text
App: willResignActive
Scene: inactive
App: didEnterBackground
Scene: background
App: willEnterForeground
Scene: inactive
App: didBecomeActive
Scene: active
```

The app and scene callbacks report related but distinct state transitions. The OS may skip intermediate callbacks in some circumstances. `applicationWillTerminate` is best effort and must not be relied on for essential persistence.
