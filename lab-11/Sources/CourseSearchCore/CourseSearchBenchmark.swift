import Foundation

public struct SearchRun: Equatable {
    public let matchedCourseIDs: [[Int]]
    public let elapsedMilliseconds: Double
    public let normalizedTitleCount: Int

    public var totalMatches: Int {
        var count = 0
        for group in matchedCourseIDs {
            count += group.count
        }
        return count
    }
}

public struct SearchBenchmarkReport: Equatable {
    public let courseCount: Int
    public let queries: [String]
    public let baseline: SearchRun
    public let indexed: SearchRun

    public var resultsMatch: Bool {
        return baseline.matchedCourseIDs == indexed.matchedCourseIDs
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
        var results: [[Int]] = []

        for query in queries {
            let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            var matches: [Int] = []
            if normalizedQuery.isEmpty {
                matches = courses.map { $0.id }
            } else {
                for course in courses {
                    if course.title.lowercased().contains(normalizedQuery) {
                        matches.append(course.id)
                    }
                }
            }
            results.append(matches)
        }

        let elapsed = (ProcessInfo.processInfo.systemUptime - start) * 1_000
        return SearchRun(
            matchedCourseIDs: results,
            elapsedMilliseconds: elapsed,
            normalizedTitleCount: courses.count * queries.count
        )
    }

    private static func runIndexed(courses: [Course], queries: [String]) -> SearchRun {
        let start = ProcessInfo.processInfo.systemUptime
        let index = CourseSearchIndex(courses: courses)
        var results: [[Int]] = []

        for query in queries {
            results.append(index.search(query).map { $0.id })
        }

        let elapsed = (ProcessInfo.processInfo.systemUptime - start) * 1_000
        return SearchRun(
            matchedCourseIDs: results,
            elapsedMilliseconds: elapsed,
            normalizedTitleCount: index.normalizedTitleCount
        )
    }
}
