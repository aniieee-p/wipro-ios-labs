import Foundation

public struct Course: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    public let title: String
    public let instructor: String
    public let duration: String
    public let summary: String

    public init(
        id: String,
        title: String,
        instructor: String,
        duration: String,
        summary: String
    ) {
        self.id = id
        self.title = title
        self.instructor = instructor
        self.duration = duration
        self.summary = summary
    }

    public static let samples = [
        Course(
            id: "swift-basics",
            title: "Swift Fundamentals",
            instructor: "A. Morgan",
            duration: "4 weeks",
            summary: "Learn Swift syntax, value types, collections, and safe optional handling."
        ),
        Course(
            id: "uikit",
            title: "UIKit Essentials",
            instructor: "J. Lee",
            duration: "3 weeks",
            summary: "Build responsive interfaces with UIKit controls, Auto Layout, and navigation."
        ),
        Course(
            id: "concurrency",
            title: "Swift Concurrency",
            instructor: "R. Patel",
            duration: "2 weeks",
            summary: "Practice async functions, tasks, task groups, and actor-based isolation."
        )
    ]
}
