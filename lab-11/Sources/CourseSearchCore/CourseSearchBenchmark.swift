import Foundation

public struct SearchRun: Equatable, Sendable {
    public let matchedCourseIDs: [[Int]]
    public let elapsedMilliseconds: Double
    public let normalizedTitleCount: Int

    public var totalMatches: Int {
        matchedCourseIDs.reduce(0) { $0 + $1.count }
    }
}

public struct SearchBenchmarkReport: Equatable, Sendable {
    public let courseCount: Int
    public let queries: [String]
    public let baseline: SearchRun
    public let indexed: SearchRun

    public var resultsMatch: Bool {
        baseline.matchedCourseIDs == indexed.matchedCourseIDs
    }
}

public enum CourseSearchBenchmark {
    public static let defaultQueries = [
        "swift",
        "network",
        "security",
        "ui",
        "concurrency",
        "course 1",
        "profiling",
        "testing"
    ]

    public static func run(
        courseCount: Int = 20_000,
        queries: [String] = defaultQueries
    ) -> SearchBenchmarkReport {
        precondition(courseCount >= 0)
        let courses = Course.sampleCatalog(count: courseCount)
        let baseline = runBaseline(courses: courses, queries: queries)
        let indexed = runIndexed(courses: courses, queries: queries)

        return SearchBenchmarkReport(
            courseCount: courseCount,
            queries: queries,
            baseline: baseline,
            indexed: indexed
        )
    }

    private static func runBaseline(courses: [Course], queries: [String]) -> SearchRun {
        let start = ProcessInfo.processInfo.systemUptime
        let results = queries.map { query in
            let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            guard !normalizedQuery.isEmpty else { return courses.map(\.id) }
            return courses.compactMap { course in
                course.title.lowercased().contains(normalizedQuery) ? course.id : nil
            }
        }
        let elapsedMilliseconds = (ProcessInfo.processInfo.systemUptime - start) * 1_000

        return SearchRun(
            matchedCourseIDs: results,
            elapsedMilliseconds: elapsedMilliseconds,
            normalizedTitleCount: courses.count * queries.filter {
                !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }.count
        )
    }

    private static func runIndexed(courses: [Course], queries: [String]) -> SearchRun {
        let start = ProcessInfo.processInfo.systemUptime
        let index = CourseSearchIndex(courses: courses)
        let results = queries.map { query in
            index.search(query).map(\.id)
        }
        let elapsedMilliseconds = (ProcessInfo.processInfo.systemUptime - start) * 1_000

        return SearchRun(
            matchedCourseIDs: results,
            elapsedMilliseconds: elapsedMilliseconds,
            normalizedTitleCount: index.normalizedTitleCount
        )
    }
}
