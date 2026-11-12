# Milestone 3 test output

The portable package and test target built with Swift 6.4.2 on Windows.

```text
testDecodesJSONIntoNestedCodableModels passed
testEmptyResponseProducesEmptyState passed
testMalformedEmailIsReported passed
testMalformedResponseBecomesDecodingError passed
testMissingRequiredFieldsAreReportedTogether passed
testNonSuccessStatusBecomesHTTPError passed
testTransportFailureProducesFailureState passed
testValidProfilePasses passed
Executed 8 tests, with 0 failures (0 unexpected)
Test Suite 'All tests' passed
```

SwiftPM emitted a Windows environment warning that it could not create the convenience `debug` symbolic link in the workspace. The build and tests completed successfully.

UIKit source files passed Swift syntax parsing, and `Info.plist` parsed successfully. The iOS app cannot be built or run on this Windows host because Xcode and the iOS SDK are unavailable.
