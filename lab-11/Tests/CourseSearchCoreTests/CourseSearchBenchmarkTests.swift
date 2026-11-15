import XCTest
@testable import CourseSearchCore

final class CourseSearchBenchmarkTests: XCTestCase {
    func testIndexedSearchReturnsSameMatchesAsBaseline() {
        let report = CourseSearchBenchmark.run(courseCount: 128)

        XCTAssertTrue(report.resultsMatch)
    }

    func testIndexNormalizesEachTitleOnlyOnceForRepeatedQueries() {
        let report = CourseSearchBenchmark.run(courseCount: 128)

        XCTAssertEqual(report.baseline.normalizedTitleCount, 128 * report.queries.count)
        XCTAssertEqual(report.indexed.normalizedTitleCount, 128)
        XCTAssertLessThan(report.indexed.normalizedTitleCount, report.baseline.normalizedTitleCount)
    }

    func testSearchIsCaseInsensitive() {
        let index = CourseSearchIndex(courses: [
            Course(id: 1, title: "Swift Fundamentals"),
            Course(id: 2, title: "UIKit Essentials")
        ])

        XCTAssertEqual(index.search("SWIFT").map(\.id), [1])
    }

    func testSearchTrimsWhitespaceAroundQuery() {
        let index = CourseSearchIndex(courses: [
            Course(id: 1, title: "Swift Fundamentals")
        ])

        XCTAssertEqual(index.search("  swift  ").map(\.id), [1])
    }

    func testEmptyQueryReturnsEveryCourse() {
        let courses = Course.sampleCatalog(count: 4)
        let index = CourseSearchIndex(courses: courses)

        XCTAssertEqual(index.search("").map(\.id), courses.map(\.id))
    }

    func testWhitespaceQueryReturnsEveryCourse() {
        let courses = Course.sampleCatalog(count: 4)
        let index = CourseSearchIndex(courses: courses)

        XCTAssertEqual(index.search(" \n ").map(\.id), courses.map(\.id))
    }

    func testNoMatchReturnsEmptyResults() {
        let index = CourseSearchIndex(courses: Course.sampleCatalog(count: 4))

        XCTAssertTrue(index.search("not-a-course").isEmpty)
    }

    func testEmptyCatalogAndNoQueriesHaveZeroWork() {
        let report = CourseSearchBenchmark.run(courseCount: 0, queries: [])

        XCTAssertTrue(report.resultsMatch)
        XCTAssertEqual(report.baseline.normalizedTitleCount, 0)
        XCTAssertEqual(report.indexed.normalizedTitleCount, 0)
        XCTAssertEqual(report.baseline.totalMatches, 0)
        XCTAssertEqual(report.indexed.totalMatches, 0)
    }

    func testSampleCatalogIsDeterministic() {
        XCTAssertEqual(Course.sampleCatalog(count: 20), Course.sampleCatalog(count: 20))
    }
}
