# Lab 5D test output

The package and test targets built successfully with Swift 6.4.2 on Windows. The repeated test suite reported:

```text
Test Case 'CounterExperimentTests.testActorCounterIsExactAcrossRepeatedConcurrentRuns' passed
Test Case 'CounterExperimentTests.testZeroTasksProduceZeroCounts' passed
Executed 2 tests, with 0 failures (0 unexpected)
Test Suite 'All tests' passed
```

SwiftPM also emitted a Windows environment warning that it could not create the convenience `debug` symbolic link in the OneDrive workspace. It did not prevent the build or test run.
