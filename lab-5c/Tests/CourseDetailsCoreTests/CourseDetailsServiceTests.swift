import XCTest
@testable import CourseDetailsCore

final class CourseDetailsServiceTests: XCTestCase {
    func testTaskGroupReturnsAllResultsInStableOrder() async throws {
        let service = CourseDetailsService(delay: .milliseconds(10))

        let result = try await service.fetchConcurrently(ids: ["D", "B", "A", "C"])

        XCTAssertEqual(result.outcomes.map(\.id), ["A", "B", "C", "D"])
        XCTAssertTrue(result.outcomes.allSatisfy {
            if case .success = $0 { return true }
            return false
        })
    }

    func testTaskGroupKeepsSuccessfulResultsWhenAChildFails() async throws {
        let service = CourseDetailsService(
            delay: .milliseconds(10),
            failingIDs: ["B"]
        )

        let result = try await service.fetchConcurrently(ids: ["A", "B", "C"])

        XCTAssertEqual(result.outcomes.map(\.id), ["A", "B", "C"])
        XCTAssertEqual(result.outcomes[1], .failure(id: "B", message: "Course B could not be loaded."))
        XCTAssertEqual(result.outcomes.filter {
            if case .success = $0 { return true }
            return false
        }.count, 2)
    }

    func testTaskGroupIsFasterThanSequentialFetchForSameDelays() async throws {
        let service = CourseDetailsService(delay: .milliseconds(80))
        let ids = ["A", "B", "C", "D"]

        let sequential = try await service.fetchSequentially(ids: ids)
        let concurrent = try await service.fetchConcurrently(ids: ids)

        XCTAssertLessThan(concurrent.elapsedSeconds, sequential.elapsedSeconds)
    }

    func testCancellingTaskGroupThrowsCancellationError() async {
        let service = CourseDetailsService(delay: .seconds(1))
        let task = Task {
            try await service.fetchConcurrently(ids: ["A", "B", "C", "D"])
        }
        task.cancel()

        do {
            _ = try await task.value
            XCTFail("Expected task-group work to be cancelled.")
        } catch is CancellationError {
            XCTAssertTrue(task.isCancelled)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
