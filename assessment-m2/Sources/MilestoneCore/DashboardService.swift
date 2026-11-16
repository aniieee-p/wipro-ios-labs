
import Foundation

public struct DashboardService: Sendable {    private let delaySeconds: Double

    public init(delaySeconds: Double = 0.8) {
        self.delaySeconds = delaySeconds
    }

    public func loadDashboard(
        failingSource: DashboardSource? = nil
    ) async throws -> DashboardData {
        let parts = try await withThrowingTaskGroup(
            of: DashboardPart.self,
            returning: [DashboardPart].self
        ) { group in
            group.addTask {
                try await self.fetchCourses(
                    failing: failingSource == .courses
                )
            }

            group.addTask {
                try await self.fetchAnnouncements(
                    failing: failingSource == .announcements
                )
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

        return DashboardData(
            courses: courses,
            announcements: announcements
        )
    }

    private func fetchCourses(failing: Bool) async throws -> DashboardPart {
        try await Task.sleep(
            nanoseconds: UInt64(delaySeconds * 1_000_000_000)
        )
        try Task.checkCancellation()

        if failing {
            throw DashboardError.unavailable(.courses)
        }

        return .courses([
            CourseSummary(
                title: "SwiftUI Essentials",
                instructor: "M. Chen"
            ),
            CourseSummary(
                title: "Concurrency in Swift",
                instructor: "R. Singh"
            )
        ])
    }

    private func fetchAnnouncements(failing: Bool) async throws -> DashboardPart {
        try await Task.sleep(
            nanoseconds: UInt64(delaySeconds * 1_000_000_000)
        )
        try Task.checkCancellation()

        if failing {
            throw DashboardError.unavailable(.announcements)
        }

        return .announcements([
            Announcement(
                message: "Concurrency workshop starts Friday."
            ),
            Announcement(
                message: "Your project review is ready."
            )
        ])
    }
}

private enum DashboardPart {
    case courses([CourseSummary])
    case announcements([Announcement])
}
