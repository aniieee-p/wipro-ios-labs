import Foundation

public struct DashboardService: Sendable {
    private let delay: Duration

    public init(delay: Duration = .milliseconds(800)) {
        self.delay = delay
    }

    public func loadDashboard(failingSource: DashboardSource? = nil) async throws -> DashboardData {
        let parts = try await withThrowingTaskGroup(
            of: DashboardPart.self,
            returning: [DashboardPart].self
        ) { group in
            group.addTask {
                try await fetchCourses(failing: failingSource == .courses)
            }
            group.addTask {
                try await fetchAnnouncements(failing: failingSource == .announcements)
            }

            var results: [DashboardPart] = []
            for try await part in group {
                results.append(part)
            }
            return results
        }

        var courses: [CourseSummary] = []
        var announcements: [Announcement] = []
        for part in parts {
            switch part {
            case .courses(let values):
                courses = values
            case .announcements(let values):
                announcements = values
            }
        }
        return DashboardData(courses: courses, announcements: announcements)
    }

    private func fetchCourses(failing: Bool) async throws -> DashboardPart {
        try await Task.sleep(for: delay)
        try Task.checkCancellation()
        if failing { throw DashboardError.unavailable(.courses) }
        return .courses([
            CourseSummary(title: "SwiftUI Essentials", instructor: "M. Chen"),
            CourseSummary(title: "Concurrency in Swift", instructor: "R. Singh")
        ])
    }

    private func fetchAnnouncements(failing: Bool) async throws -> DashboardPart {
        try await Task.sleep(for: delay)
        try Task.checkCancellation()
        if failing { throw DashboardError.unavailable(.announcements) }
        return .announcements([
            Announcement(message: "Concurrency workshop starts Friday."),
            Announcement(message: "Your project review is ready.")
        ])
    }
}

private enum DashboardPart: Sendable {
    case courses([CourseSummary])
    case announcements([Announcement])
}
