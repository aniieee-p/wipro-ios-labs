import XCTest
@testable import UnitTestPracticeCore

private struct StubCourseService: CourseService {
    let result: Result<[Course], StubError>

    func fetchCourses() throws -> [Course] {
        try result.get()
    }
}

private enum StubError: Error {
    case unavailable
}

final class CourseListViewModelTests: XCTestCase {
    func testLoadPublishesCoursesReturnedByInjectedService() {
        let expected = [
            Course(id: "swift", title: "Swift Fundamentals"),
            Course(id: "uikit", title: "UIKit Essentials")
        ]
        let viewModel = CourseListViewModel(service: StubCourseService(result: .success(expected)))

        viewModel.loadCourses()

        XCTAssertEqual(viewModel.state, .loaded(expected))
    }

    func testLoadTransitionsToEmptyWhenServiceReturnsNoCourses() {
        let viewModel = CourseListViewModel(service: StubCourseService(result: .success([])))

        viewModel.loadCourses()

        XCTAssertEqual(viewModel.state, .empty)
    }

    func testLoadExposesFailureWhenInjectedServiceThrows() {
        let viewModel = CourseListViewModel(service: StubCourseService(result: .failure(.unavailable)))

        viewModel.loadCourses()

        guard case let .failed(message) = viewModel.state else {
            return XCTFail("Expected a failed state")
        }
        XCTAssertFalse(message.isEmpty)
    }
}
