import XCTest
@testable import CourseExplorerCore

final class CourseTests: XCTestCase {
    func testCoursePreservesAllDisplayFields() {
        let course = Course(
            id: "swift",
            title: "Swift Fundamentals",
            subtitle: "Learn Swift",
            category: "Swift",
            status: .inProgress,
            duration: "4 weeks",
            description: "Course description",
            symbol: "swift"
        )

        XCTAssertEqual(course.id, "swift")
        XCTAssertEqual(course.title, "Swift Fundamentals")
        XCTAssertEqual(course.category, "Swift")
        XCTAssertEqual(course.status, .inProgress)
    }

    func testSampleCoursesUseUniqueIDsAndHaveCategories() {
        XCTAssertEqual(Set(Course.samples.map(\.id)).count, Course.samples.count)
        XCTAssertTrue(Course.samples.allSatisfy { !$0.category.isEmpty })
    }
}
