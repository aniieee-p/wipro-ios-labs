import Foundation

public struct Course: Equatable, Identifiable, Sendable {
    public let id: Int
    public let title: String

    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }

    public static func sampleCatalog(count: Int) -> [Course] {
        precondition(count >= 0)
        let topics = [
            "Swift Fundamentals",
            "UIKit Essentials",
            "Networking",
            "SwiftUI Layout",
            "Concurrency",
            "Testing Strategies",
            "App Security",
            "Performance Profiling"
        ]

        return (0..<count).map { index in
            Course(
                id: index,
                title: "Course \(index) · \(topics[index % topics.count])"
            )
        }
    }
}
