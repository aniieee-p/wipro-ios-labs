
import Foundation

public struct Course: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    public let title: String
    public let instructor: String
    public let category: String
    public let credits: Int
    public let weekday: Int
    public let startMinute: Int
    public let durationMinutes: Int
    public let summary: String

    public init(
        id: String,
        title: String,
        instructor: String,
        category: String,
        credits: Int,
        weekday: Int,
        startMinute: Int,
        durationMinutes: Int,
        summary: String
    ) {
        self.id = id
        self.title = title
        self.instructor = instructor
        self.category = category
        self.credits = credits
        self.weekday = weekday
        self.startMinute = startMinute
        self.durationMinutes = durationMinutes
        self.summary = summary
    }

    public var endMinute: Int {
        startMinute + durationMinutes
    }

    public var timeDescription: String {
        "\(Self.weekdayName(weekday)), \(Self.formatTime(startMinute))–\(Self.formatTime(endMinute))"
    }

    public static func weekdayName(_ weekday: Int) -> String {
        let names = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        guard (1...names.count).contains(weekday) else {
            return "Unknown day"
        }
        return names[weekday - 1]
    }

    public static func formatTime(_ minutes: Int) -> String {
        let hour = minutes / 60
        let minute = minutes % 60
        let suffix = hour < 12 ? "AM" : "PM"
        let displayHour = hour % 12 == 0 ? 12 : hour % 12
        return String(format: "%d:%02d %@", displayHour, minute, suffix)
    }

    public static let samples = [
        Course(
            id: "swift-foundations",
            title: "Swift Foundations",
            instructor: "Maya Chen",
            category: "Programming",
            credits: 3,
            weekday: 1,
            startMinute: 540,
            durationMinutes: 90,
            summary: "Build confidence with Swift value types, collections, optionals, and protocols."
        ),
        Course(
            id: "ios-interface-design",
            title: "iOS Interface Design",
            instructor: "Jordan Lee",
            category: "Design",
            credits: 3,
            weekday: 1,
            startMinute: 660,
            durationMinutes: 90,
            summary: "Practice accessible layouts, interaction patterns, and reusable iOS screens."
        ),
        Course(
            id: "mobile-networking",
            title: "Mobile Networking",
            instructor: "Avery Patel",
            category: "Engineering",
            credits: 4,
            weekday: 2,
            startMinute: 600,
            durationMinutes: 120,
            summary: "Work with HTTP, Codable models, loading states, and resilient API clients."
        ),
        Course(
            id: "swift-concurrency",
            title: "Swift Concurrency",
            instructor: "Noah Kim",
            category: "Programming",
            credits: 3,
            weekday: 2,
            startMinute: 660,
            durationMinutes: 90,
            summary: "Use structured concurrency, actors, cancellation, and safe shared state."
        ),
        Course(
            id: "testing-workshop",
            title: "Testing Workshop",
            instructor: "Riley Morgan",
            category: "Engineering",
            credits: 3,
            weekday: 3,
            startMinute: 780,
            durationMinutes: 90,
            summary: "Design focused unit tests and automate important user journeys."
        ),
        Course(
            id: "product-studio",
            title: "Product Studio",
            instructor: "Sam Rivera",
            category: "Design",
            credits: 3,
            weekday: 4,
            startMinute: 840,
            durationMinutes: 90,
            summary: "Turn a user problem into a small, testable product experience."
        ),
        Course(
            id: "ux-research",
            title: "UX Research Methods",
            instructor: "Taylor Brooks",
            category: "Design",
            credits: 3,
            weekday: 5,
            startMinute: 600,
            durationMinutes: 90,
            summary: "Use interviews and usability studies to make evidence-based product decisions."
        )
    ]
}
