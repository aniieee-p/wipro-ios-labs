import XCTest
@testable import CourseLoadingCore

final class CourseCatalogServiceTests: XCTestCase {
    private let service = CourseCatalogService(stepDelay: .milliseconds(1))

    func testFetchSuccessReturnsCourses() async throws {
        let courses = try await service.fetchCourses(for: .success)

        XCTAssertEqual(courses.map(\.id), ["swift", "uikit", "concurrency"])
    }

    func testFetchEmptyReturnsNoCourses() async throws {
        let courses = try await service.fetchCourses(for: .empty)

        XCTAssertTrue(courses.isEmpty)
    }

    func testFetchFailureThrowsServiceError() async {
        do {
            _ = try await service.fetchCourses(for: .failure)
            XCTFail("Expected the simulated service error.")
        } catch {
            XCTAssertEqual(error as? CourseFetchError, .serviceUnavailable)
        }
    }

    func testFetchRespondsToCancellation() async {
        let service = self.service
        let task = Task {
            try await service.fetchCourses(for: .success)
        }
        task.cancel()

        do {
            _ = try await task.value
            XCTFail("Expected the fetch to be cancelled.")
        } catch is CancellationError {
            XCTAssertTrue(task.isCancelled)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
