import Foundation

public struct CourseDetailError: Error, Equatable, LocalizedError, Sendable {
    public let courseID: String

    public init(courseID: String) {
        self.courseID = courseID
    }

    public var errorDescription: String? {
        "Course \(courseID) could not be loaded."
    }
}

public struct CourseDetailsService: Sendable {
    private let delay: Duration
    private let failingIDs: Set<String>

    public init(
        delay: Duration = .milliseconds(700),
        failingIDs: Set<String> = []
    ) {
        self.delay = delay
        self.failingIDs = failingIDs
    }

    public func fetchSequentially(ids: [String]) async throws -> TimedCourseDetails {
        let clock = ContinuousClock()
        let start = clock.now
        var outcomes: [CourseDetailOutcome] = []

        for id in ids {
            try Task.checkCancellation()
            outcomes.append(try await fetchOutcome(for: id))
        }

        return TimedCourseDetails(
            outcomes: outcomes.sorted { $0.id < $1.id },
            elapsedSeconds: seconds(from: start.duration(to: clock.now))
        )
    }

    public func fetchConcurrently(ids: [String]) async throws -> TimedCourseDetails {
        let clock = ContinuousClock()
        let start = clock.now
        let outcomes = try await withThrowingTaskGroup(
            of: CourseDetailOutcome.self,
            returning: [CourseDetailOutcome].self
        ) { group in
            for id in ids {
                group.addTask {
                    try Task.checkCancellation()
                    return try await fetchOutcome(for: id)
                }
            }

            var collected: [CourseDetailOutcome] = []
            for try await outcome in group {
                collected.append(outcome)
            }
            return collected.sorted { $0.id < $1.id }
        }

        return TimedCourseDetails(
            outcomes: outcomes,
            elapsedSeconds: seconds(from: start.duration(to: clock.now))
        )
    }

    private func fetchOutcome(for id: String) async throws -> CourseDetailOutcome {
        do {
            try await fetchDetail(for: id)
            return .success(
                CourseDetail(
                    id: id,
                    title: "Course \(id)",
                    instructor: "Instructor \(id)"
                )
            )
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            return .failure(id: id, message: error.localizedDescription)
        }
    }

    private func fetchDetail(for id: String) async throws {
        try await Task.sleep(for: delay)
        try Task.checkCancellation()

        if failingIDs.contains(id) {
            throw CourseDetailError(courseID: id)
        }
    }

    private func seconds(from duration: Duration) -> Double {
        let components = duration.components
        return Double(components.seconds) + Double(components.attoseconds) / 1_000_000_000_000_000_000
    }
}
