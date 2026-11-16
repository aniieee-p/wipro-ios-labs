
import Foundation

public enum CourseFetchError: Error, Equatable, Sendable {
    case serviceUnavailable
}

public struct CourseCatalogService: Sendable {
    // Delay in seconds between loading steps
    private let stepDelay: Double

    public init(stepDelay: Double = 0.35) {
        self.stepDelay = stepDelay
    }

    public func fetchCourses(for scenario: CourseFetchScenario) async throws -> [Course] {
        // Simulate 5 loading steps
        for _ in 0..<5 {
            try Task.checkCancellation()
            try await Task.sleep(
                nanoseconds: UInt64(stepDelay * 1_000_000_000)
            )
        }

        try Task.checkCancellation()

        switch scenario {
        case .success:
            return [
                Course(id: "swift", title: "Swift Fundamentals", instructor: "A. Morgan"),
                Course(id: "uikit", title: "Building Interfaces with UIKit", instructor: "J. Lee"),
                Course(id: "concurrency", title: "Swift Concurrency", instructor: "R. Patel")
            ]

        case .empty:
            return []

        case .failure:
            throw CourseFetchError.serviceUnavailable
        }
    }
}
