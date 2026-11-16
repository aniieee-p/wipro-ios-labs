
import XCTest
@testable import CoursePlannerCore

final class CoursePlannerModelTests: XCTestCase {
    func testAddingCourseUpdatesPlanAndCreditTotals() {
        var planner = makePlanner()

        XCTAssertTrue(isSuccess(planner.addCourse(id: "swift")))
        XCTAssertEqual(planner.plannedCourseIDs, ["swift"])
        XCTAssertEqual(planner.totalCredits, 3)
        XCTAssertEqual(planner.remainingCredits, 15)
    }

    func testRejectsCourseThatIsAlreadyPlanned() {
        var planner = makePlanner(plannedCourseIDs: ["swift"])

        XCTAssertFailure(planner.addCourse(id: "swift"), equals: .alreadyPlanned)
        XCTAssertEqual(planner.plannedCourseIDs, ["swift"])
    }

    func testRejectsUnknownCourseID() {
        var planner = makePlanner()

        XCTAssertFailure(planner.addCourse(id: "missing"), equals: .courseNotFound)
        XCTAssertTrue(planner.plannedCourseIDs.isEmpty)
    }

    func testRejectsOverlappingCoursesOnSameWeekday() {
        let first = course(id: "first", weekday: 1, start: 540, duration: 90)
        let overlap = course(id: "overlap", weekday: 1, start: 600, duration: 60)
        var planner = makePlanner(
            courses: [first, overlap],
            plannedCourseIDs: ["first"]
        )

        XCTAssertFailure(
            planner.addCourse(id: "overlap"),
            equals: .scheduleConflict(withCourseID: "first")
        )
    }

    func testAllowsBackToBackCourses() {
        let first = course(id: "first", weekday: 1, start: 540, duration: 60)
        let next = course(id: "next", weekday: 1, start: 600, duration: 60)
        var planner = makePlanner(
            courses: [first, next],
            plannedCourseIDs: ["first"]
        )

        XCTAssertTrue(isSuccess(planner.addCourse(id: "next")))
        XCTAssertEqual(planner.plannedCourseIDs, ["first", "next"])
    }

    func testCoursesOnDifferentDaysDoNotConflict() {
        let monday = course(id: "monday", weekday: 1, start: 540, duration: 90)
        let tuesday = course(id: "tuesday", weekday: 2, start: 540, duration: 90)
        var planner = makePlanner(
            courses: [monday, tuesday],
            plannedCourseIDs: ["monday"]
        )

        XCTAssertTrue(isSuccess(planner.addCourse(id: "tuesday")))
    }

    func testRejectsCourseThatExceedsCreditLimit() {
        let heavy = course(id: "heavy", credits: 4, weekday: 1, start: 540)
        var planner = makePlanner(courses: [heavy], creditLimit: 3)

        XCTAssertFailure(
            planner.addCourse(id: "heavy"),
            equals: .creditLimitExceeded(limit: 3)
        )
        XCTAssertEqual(planner.totalCredits, 0)
    }

    func testRemovingCourseRestoresAvailableCredits() {
        var planner = makePlanner(plannedCourseIDs: ["swift"])

        XCTAssertTrue(planner.removeCourse(id: "swift"))
        XCTAssertFalse(planner.removeCourse(id: "swift"))
        XCTAssertEqual(planner.totalCredits, 0)
        XCTAssertEqual(planner.remainingCredits, planner.creditLimit)
    }

    func testSearchMatchesTitleInstructorAndCategoryWithoutCaseSensitivity() {
        let courses = [
            course(
                id: "swift",
                title: "Swift Foundations",
                instructor: "Maya Chen",
                category: "Programming"
            ),
            course(
                id: "design",
                title: "Visual Studio",
                instructor: "Jordan Lee",
                category: "Design"
            )
        ]
        let planner = makePlanner(courses: courses)

        XCTAssertEqual(planner.search("SWIFT").map { $0.id }, ["swift"])
        XCTAssertEqual(planner.search("jordan").map { $0.id }, ["design"])
        XCTAssertEqual(planner.search(" design ").map { $0.id }, ["design"])
    }

    func testEmptySearchReturnsEntireCatalogAndMissingSearchReturnsEmpty() {
        let planner = makePlanner()

        XCTAssertEqual(planner.search("  "), planner.courses)
        XCTAssertTrue(planner.search("unknown topic").isEmpty)
    }

    func testPlannedCoursesAreSortedByWeekdayAndStartTime() {
        let afternoon = course(id: "afternoon", weekday: 2, start: 780)
        let early = course(id: "early", weekday: 1, start: 540)
        let later = course(id: "later", weekday: 1, start: 660)
        let planner = makePlanner(
            courses: [afternoon, later, early],
            plannedCourseIDs: ["afternoon", "later", "early"]
        )

        XCTAssertEqual(
            planner.plannedCourses.map { $0.id },
            ["early", "later", "afternoon"]
        )
    }

    func testReplacingCatalogDropsPlannedCoursesNoLongerAvailable() {
        var planner = makePlanner(plannedCourseIDs: ["swift", "design"])

        planner.replaceCatalog(with: [planner.courses[0]])

        XCTAssertEqual(planner.plannedCourseIDs, ["swift"])
    }

    func testInitialPlanIgnoresIDsNotInCatalog() {
        let planner = makePlanner(plannedCourseIDs: ["swift", "missing"])

        XCTAssertEqual(planner.plannedCourseIDs, ["swift"])
    }

    private func makePlanner(
        courses: [Course]? = nil,
        plannedCourseIDs: Set<String> = [],
        creditLimit: Int = 18
    ) -> CoursePlannerModel {
        let catalog = courses ?? [
            course(id: "swift", credits: 3, weekday: 1, start: 540),
            course(id: "design", credits: 2, weekday: 2, start: 660)
        ]

        return CoursePlannerModel(
            courses: catalog,
            plannedCourseIDs: plannedCourseIDs,
            creditLimit: creditLimit
        )
    }

    private func course(
        id: String,
        title: String? = nil,
        instructor: String = "Instructor",
        category: String = "Programming",
        credits: Int = 3,
        weekday: Int = 1,
        start: Int = 540,
        duration: Int = 90
    ) -> Course {
        Course(
            id: id,
            title: title ?? id.capitalized,
            instructor: instructor,
            category: category,
            credits: credits,
            weekday: weekday,
            startMinute: start,
            durationMinutes: duration,
            summary: "A sample course for testing planner rules."
        )
    }

    private func isSuccess(_ result: Result<Void, PlannerError>) -> Bool {
        if case .success = result {
            return true
        }
        return false
    }

    private func XCTAssertFailure(
        _ result: Result<Void, PlannerError>,
        equals expectedError: PlannerError,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard case .failure(let actualError) = result else {
            XCTFail("Expected failure with \(expectedError), but got success.", file: file, line: line)
            return
        }

        XCTAssertEqual(actualError, expectedError, file: file, line: line)
    }
}

final class LocalCourseCatalogServiceTests: XCTestCase {
    func testReturnsInjectedDeterministicCatalog() throws {
        let courses = [
            Course(
                id: "sample",
                title: "Sample",
                instructor: "Instructor",
                category: "Testing",
                credits: 1,
                weekday: 1,
                startMinute: 540,
                durationMinutes: 60,
                summary: "Injected test course."
            )
        ]
        let service = LocalCourseCatalogService(courses: courses)

        XCTAssertEqual(try service.fetchCourses(), courses)
    }

    func testDefaultCatalogHasUniqueIDs() throws {
        let courses = try LocalCourseCatalogService().fetchCourses()

        XCTAssertFalse(courses.isEmpty)
        XCTAssertEqual(Set(courses.map { $0.id }).count, courses.count)
    }
}
