import XCTest
@testable import CourseNavigationCore

final class CourseNavigationTests: XCTestCase {
    func testCourseRouteCarriesTheSelectedCourse() {
        let selectedCourse = Course.samples[1]
        let route = CourseNavigationRoute.course(selectedCourse)

        guard case let .course(course) = route else {
            return XCTFail("Expected a course destination")
        }

        XCTAssertEqual(course, selectedCourse)
    }

    func testAboutRouteIsDistinctFromCourseRoutes() {
        XCTAssertNotEqual(
            CourseNavigationRoute.about,
            CourseNavigationRoute.course(Course.samples[0])
        )
    }

    func testSampleCoursesHaveUniqueIDs() {
        XCTAssertEqual(Set(Course.samples.map(\.id)).count, Course.samples.count)
    }
}
