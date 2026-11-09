# Lab 5A event log

The app prints timestamp-free queue/thread labels to the Xcode console and shows the latest UI events in the screen log. The two delayed results can finish in either order; the coordinator collects them safely and presents them in a stable order.

```text
[GCD Lab] queue=main thread=main-thread Screen ready
[GCD Lab] queue=main thread=main-thread Work started; button disabled and indicator shown
[GCD Lab] queue=global.asyncAfter thread=background-thread Scheduled 2 independent operations
[GCD Lab] queue=global(qos: .userInitiated) thread=background-thread Finished Profile operation
[GCD Lab] queue=global(qos: .userInitiated) thread=background-thread Finished Messages operation
[GCD Lab] queue=main thread=main-thread Delivering 2 results
[GCD Lab] queue=main thread=main-thread UI updated with 2 results
```

The exact timing and background thread names are runtime-dependent. Both simulated responses use `DispatchQueue.global(...).asyncAfter`, so neither blocks the main thread.
