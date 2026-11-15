# Lab 11 Profiling Demo

This package and SwiftUI demo compare repeated title normalization against a reusable precomputed course-search index.

## Run and test

On macOS, attach `CourseSearchCore` as a local package dependency to an iOS App target and add the files in `App/`. Run on a simulator/device, then use **Product > Profile > Time Profiler** and tap the repeatable workload button. See [lab-report.md](./lab-report.md) for controlled conditions, baseline/after measurements, caveats, and required evidence.

Run `swift test` in this folder for deterministic result-equivalence and operation-count tests. No profiler results are included: Xcode/Instruments are unavailable in this Windows workspace.
