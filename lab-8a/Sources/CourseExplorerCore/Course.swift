import Foundation

public enum CourseStatus: String, CaseIterable, Identifiable, Sendable {
    case inProgress = "In progress"
    case new = "New"
    case completed = "Completed"

    public var id: Self { self }
}

public struct Course: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let category: String
    public let status: CourseStatus
    public let duration: String
    public let description: String
    public let symbol: String

    public init(
        id: String,
        title: String,
        subtitle: String,
        category: String,
        status: CourseStatus,
        duration: String,
        description: String,
        symbol: String
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.status = status
        self.duration = duration
        self.description = description
        self.symbol = symbol
    }

    public static let samples = [
        Course(
            id: "swift-fundamentals",
            title: "Swift Fundamentals",
            subtitle: "Build a strong foundation",
            category: "Swift",
            status: .inProgress,
            duration: "4 weeks",
            description: "Practice Swift syntax, value types, collections, optionals, and protocols through clear examples.",
            symbol: "swift"
        ),
        Course(
            id: "ui-design",
            title: "Interfaces with SwiftUI",
            subtitle: "Compose expressive screens",
            category: "Design",
            status: .new,
            duration: "3 weeks",
            description: "Create reusable SwiftUI views with state, navigation, layout containers, and accessible interactions.",
            symbol: "rectangle.3.group"
        ),
        Course(
            id: "ios-networking",
            title: "Networking for iOS",
            subtitle: "Connect apps to services",
            category: "Networking",
            status: .new,
            duration: "2 weeks",
            description: "Fetch JSON with URLSession, decode Codable models, and represent loading and error states.",
            symbol: "network"
        ),
        Course(
            id: "swift-concurrency",
            title: "Swift Concurrency",
            subtitle: "Write responsive async code",
            category: "Concurrency",
            status: .completed,
            duration: "2 weeks",
            description: "Use async/await, task groups, cancellation, and actors to write safe concurrent programs.",
            symbol: "arrow.trianglehead.2.clockwise.rotate.90"
        )
    ]
}
