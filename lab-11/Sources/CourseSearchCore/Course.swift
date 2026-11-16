import Foundation

public struct Course: Equatable, Identifiable {
    public let id: Int
    public let title: String

    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }

    public static func sampleCatalog(count: Int) -> [Course] {
        guard count >= 0 else { return [] }
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
