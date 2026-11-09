# Lab 5C: Sequential vs. Task-Group Timing

The demo fetches four course IDs. Each simulated request waits 0.7 seconds.

| Strategy | Expected elapsed time | Why |
|---|---:|---|
| Sequential `for` loop | About 2.8 seconds | Each request starts only after the previous request finishes. |
| `withThrowingTaskGroup` | About 0.7 seconds | The four independent waits overlap; completion waits for the slowest child. |

These are estimates, not guaranteed measurements. Scheduler load and device performance affect the actual times. The app measures elapsed time with `ContinuousClock` and displays both measured values on screen. Run it on a simulator or device to record the observed timings.

Choose **Fail course B** to see how partial failure is handled: each request converts an ordinary fetch error into a failure outcome, while the other child tasks continue and successful results are retained. Cancellation is not converted into a failure outcome; it is rethrown so the task group cancels its remaining children.
