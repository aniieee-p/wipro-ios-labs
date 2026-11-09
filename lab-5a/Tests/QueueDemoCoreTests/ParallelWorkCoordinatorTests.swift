import XCTest
@testable import QueueDemoCore

final class ParallelWorkCoordinatorTests: XCTestCase {
    func testReturnsBothIndependentResultsOnMainThread() async {
        let coordinator = ParallelWorkCoordinator()
        let (results, completedOnMainThread) = await withCheckedContinuation {
            (continuation: CheckedContinuation<([WorkResult], Bool), Never>) in
            coordinator.run { results in
                continuation.resume(returning: (results, Thread.isMainThread))
            }
        }

        XCTAssertEqual(results.map(\.name), ["Messages", "Profile"])
        XCTAssertTrue(completedOnMainThread)
    }
}
