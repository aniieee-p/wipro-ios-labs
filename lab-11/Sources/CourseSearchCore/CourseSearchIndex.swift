import Foundation

public struct CourseSearchIndex: Sendable {
    private let entries: [(course: Course, normalizedTitle: String)]

    public init(courses: [Course]) {
        entries = courses.map { ($0, $0.title.lowercased()) }
    }

    public func search(_ query: String) -> [Course] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !normalizedQuery.isEmpty else { return entries.map { $0.course } }
        return entries.compactMap { entry in
            entry.normalizedTitle.contains(normalizedQuery) ? entry.course : nil
        }
    }

    public var normalizedTitleCount: Int {
        entries.count
    }
}
