import Foundation

public struct CourseSummary: Equatable, Identifiable, Sendable {
    public let title: String
    public let instructor: String

    public var id: String { title }

    public init(title: String, instructor: String) {
        self.title = title
        self.instructor = instructor
    }
}

public struct Announcement: Equatable, Identifiable, Sendable {
    public let message: String

    public var id: String { message }

    public init(message: String) {
        self.message = message
    }
}

public struct DashboardData: Equatable, Sendable {
    public let courses: [CourseSummary]
    public let announcements: [Announcement]

    public init(courses: [CourseSummary], announcements: [Announcement]) {
        self.courses = courses
        self.announcements = announcements
    }
}

public enum DashboardSource: String, Sendable {
    case courses
    case announcements
}

public enum DashboardError: Error, Equatable, LocalizedError, Sendable {
    case unavailable(DashboardSource)

    public var errorDescription: String? {
        switch self {
        case .unavailable(let source):
            return "The \(source.rawValue) service is unavailable."
        }
    }
}
