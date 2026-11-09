import Foundation

public struct CourseDetail: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let instructor: String

    public init(id: String, title: String, instructor: String) {
        self.id = id
        self.title = title
        self.instructor = instructor
    }
}

public enum CourseDetailOutcome: Equatable, Sendable, Identifiable {
    case success(CourseDetail)
    case failure(id: String, message: String)

    public var id: String {
        switch self {
        case .success(let course):
            return course.id
        case .failure(let id, _):
            return id
        }
    }
}

public struct TimedCourseDetails: Equatable, Sendable {
    public let outcomes: [CourseDetailOutcome]
    public let elapsedSeconds: Double

    public init(outcomes: [CourseDetailOutcome], elapsedSeconds: Double) {
        self.outcomes = outcomes
        self.elapsedSeconds = elapsedSeconds
    }
}

public struct CourseDetailsComparison: Equatable, Sendable {
    public let sequential: TimedCourseDetails
    public let concurrent: TimedCourseDetails

    public init(sequential: TimedCourseDetails, concurrent: TimedCourseDetails) {
        self.sequential = sequential
        self.concurrent = concurrent
    }
}
