
import Foundation

public struct CourseDetailError: Error, Equatable, Sendable {
    public let courseID: String

    public init(courseID: String) {
        self.courseID = courseID
    }

    public var message: String {
        return "Course \(courseID) could not be loaded."
    }
}

public struct CourseDetailsService: Sendable {
    private let delaySeconds: Double
    private let failingIDs: Set<String>

    public init(
        delaySeconds: Double = 0.7,
        failingIDs: Set<String> = []
    ) {
        self.delaySeconds = delaySeconds
        self.failingIDs = failingIDs
    }

    // Fetch courses one at a time (sequential)
    public func fetchSequentially(ids: [String]) async throws -> TimedCourseDetails {
        let startTime = Date()
        var outcomes: [CourseDetailOutcome] = []

        for id in ids {
            try Task.checkCancellation()
            outcomes.append(try await fetchOutcome(for: id))
        }

        let elapsed = Date().timeIntervalSince(startTime)

        return TimedCourseDetails(
            outcomes: outcomes.sorted { $0.id < $1.id },
            elapsedSeconds: elapsed
        )
    }

    // Fetch all courses at the same time (concurrent)
    public func fetchConcurrently(ids: [String]) async throws -> TimedCourseDetails {
        let startTime = Date()

        let outcomes = try await withThrowingTaskGroup(
            of: CourseDetailOutcome.self,
            returning: [CourseDetailOutcome].self
        ) { group in
            for id in ids {
                group.addTask { [self] in
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

        let elapsed = Date().timeIntervalSince(startTime)

        return TimedCourseDetails(
            outcomes: outcomes,
            elapsedSeconds: elapsed
        )
    }

    // Fetch a single course and return success or failure outcome
    private func fetchOutcome(for id: String) async throws -> CourseDetailOutcome {
        do {
            try await Task.sleep(
                nanoseconds: UInt64(delaySeconds * 1_000_000_000)
            )

            try Task.checkCancellation()

            if failingIDs.contains(id) {
                throw CourseDetailError(courseID: id)
            }

            return .success(
                CourseDetail(
                    id: id,
                    title: "Course \(id)",
                    instructor: "Instructor \(id)"
                )
            )
        } catch is CancellationError {
            throw CancellationError()
        } catch let detailError as CourseDetailError {
            return .failure(
                id: id,
                message: detailError.message
            )
        } catch {
            return .failure(
                id: id,
                message: error.localizedDescription
            )
        }
    }
}
