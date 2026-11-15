# Lab 11: Instruments — Measure, Diagnose, Improve

## Investigation

**Issue selected:** repeated work during search. The baseline lowercases every course title on every query. For a catalog of `N` courses and `Q` queries, it performs `N × Q` title normalizations. The improved version builds a normalized-title index once, then reuses it for each query. This targets CPU work; it does not claim a memory or latency result without profiling.

**Runnable workload:** [SearchBenchmarkView](./App/SearchBenchmarkView.swift) runs the same deterministic 20,000-course catalog and eight fixed queries through both implementations. It runs in a detached task so the benchmark does not block the UI, verifies identical matching course IDs, and displays elapsed times and normalization counts. The model tests include small deterministic workloads and edge cases.

## Repeatable profiling procedure

1. On macOS, attach the `CourseSearchCore` package and `App/` files to an iOS app target. Build and launch the app on a named iOS Simulator or device.
2. Record device/simulator model, iOS version, Xcode version, build configuration, power/thermal conditions, and whether the app was freshly launched. Keep the same conditions before and after.
3. Open **Product > Profile** in Xcode and choose **Time Profiler**. Start recording, tap **Run repeatable workload**, and stop recording after both result sections appear.
4. Inspect the call tree for `runBaseline` and `runIndexed`. Repeat the same workload several times; compare like-for-like release-build traces and the UI's measured elapsed times. If available, use signposts or the Instruments Points of Interest track to bracket each phase.
5. Capture a real Instruments trace/screenshot before and after in [screenshots/](./screenshots/). Do not use the example observation table below as if it were measured output.

## Observation record

| Measurement | Before (baseline) | After (indexed) |
|---|---:|---:|
| Device/simulator, OS, Xcode, configuration | To be measured | Same conditions |
| Course count / query count | 20,000 / 8 | 20,000 / 8 |
| Title normalizations (deterministic work count) | 160,000 | 20,000 |
| Elapsed time in Instruments / app | Record actual result | Record actual result |
| Results equivalent | Verify in app | Verify in app |
| Trace or screenshot | Add captured evidence | Add captured evidence |

The normalization counts above follow directly from the implementation's workload. They are operation counts, **not** an Instruments measurement, memory measurement, or proof of a wall-clock speedup. Record actual observed times and only claim a measured improvement if repeated comparable traces support it.

## Change and trade-offs

`CourseSearchIndex` stores a lowercased title beside each course and searches those precomputed strings. For the fixed workload this changes title-normalization work from `N × Q` to `N`. It adds one stored normalized string per course and an upfront index-construction cost, so it may not help a tiny catalog or a one-off query. Include index construction in the after measurement, as the demo does.

## Screenshots and evidence

The `screenshots/` folder contains instructions only. This environment runs on Windows without Xcode, Instruments, or an iOS Simulator. Therefore no simulator run, trace, before/after time, or performance gain is claimed here. Complete the procedure on macOS and add the actual trace/export or screenshots before submission.
