import XCTest
@testable import ConcurrencySafetyCore

final class CounterExperimentTests: XCTestCase {
    func testActorCounterIsExactAcrossRepeatedConcurrentRuns() async {
        for _ in 0..<10 {
            let result = await CounterExperiment.run(
                taskCount: 20,
                incrementsPerTask: 500
            )

            XCTAssertEqual(result.expectedCount, 10_000)
            XCTAssertEqual(result.safeCount, result.expectedCount)
        }
    }

    func testZeroTasksProduceZeroCounts() async {
        let result = await CounterExperiment.run(taskCount: 0, incrementsPerTask: 500)

        XCTAssertEqual(result.expectedCount, 0)
        XCTAssertEqual(result.safeCount, 0)
    }
}
