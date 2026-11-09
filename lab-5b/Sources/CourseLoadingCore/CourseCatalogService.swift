import Foundation

public enum CourseFetchError: Error, Equatable, LocalizedError, Sendable {
    case serviceUnavailable

    public var errorDescription: String? {
        switch self {
        case .serviceUnavailable:
            return "The course service is temporarily unavailable."
        }
    }
}

public struct CourseCatalogService: Sendable {
    private let stepDelay: Duration

    public init(stepDelay: Duration = .milliseconds(350)) {
        self.stepDelay = stepDelay
    }

    public func fetchCourses(for scenario: CourseFetchScenario) async throws -> [Course] {
        for _ in 0..<5 {
            try Task.checkCancellation()
            try await Task.sleep(for: stepDelay)
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
