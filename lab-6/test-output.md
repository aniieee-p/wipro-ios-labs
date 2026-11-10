# Lab 6 test output

The package and test targets built successfully with Swift 6.4.2 on Windows. The six network-service tests reported:

```text
testDecodesUserAndNestedAddressAndCompany passed
testRejectsInvalidEndpoint passed
testRejectsNonSuccessHTTPStatus passed
testReportsMalformedJSON passed
testReturnsAnEmptyListForEmptyResponse passed
testWrapsTransportFailure passed
Executed 6 tests, with 0 failures (0 unexpected)
Test Suite 'All tests' passed
```

SwiftPM emitted a Windows environment warning that it could not create its convenience `debug` symbolic link in the OneDrive workspace. The build and tests completed successfully.
