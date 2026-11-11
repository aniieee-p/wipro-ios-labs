import XCTest
@testable import CourseDirectoryCore

final class CourseTests: XCTestCase {
    func testCoursePreservesPassedValues() {
        let course = Course(
            id: "swift",
            title: "Swift Fundamentals",
            instructor: "A. Morgan",
            duration: "4 weeks",
            summary: "Learn Swift."
        )

        XCTAssertEqual(course.id, "swift")
        XCTAssertEqual(course.title, "Swift Fundamentals")
        XCTAssertEqual(course.instructor, "A. Morgan")
        XCTAssertEqual(course.duration, "4 weeks")
        XCTAssertEqual(course.summary, "Learn Swift.")
    }

    func testSampleCoursesHaveUniqueIdentifiers() {
        let identifiers = Course.samples.map(\.id)

        XCTAssertEqual(Set(identifiers).count, identifiers.count)
    }
}
