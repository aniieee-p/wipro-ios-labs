# Lab 5C test output

Command:

```powershell
swift test --skip-build --scratch-path "C:\Users\anish\OneDrive\Desktop\WIPRO\wipro-ios-labs\lab-5c\build-check"
```

Result on Windows with Swift 6.4.2:

```text
Test Case 'CourseDetailsServiceTests.testCancellingTaskGroupThrowsCancellationError' passed
Test Case 'CourseDetailsServiceTests.testTaskGroupIsFasterThanSequentialFetchForSameDelays' passed
Test Case 'CourseDetailsServiceTests.testTaskGroupKeepsSuccessfulResultsWhenAChildFails' passed
Test Case 'CourseDetailsServiceTests.testTaskGroupReturnsAllResultsInStableOrder' passed
Executed 4 tests, with 0 failures (0 unexpected)
Test Suite 'All tests' passed
```

SwiftPM also reported that it could not create its convenience `debug` symbolic link in this Windows/OneDrive workspace. The built test suite nevertheless ran successfully using the explicit scratch path.
