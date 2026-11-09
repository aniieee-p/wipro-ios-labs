import Combine
import CourseDetailsCore
import Foundation

@MainActor
final class CourseComparisonModel: ObservableObject {
    @Published private(set) var comparison: CourseDetailsComparison?
    @Published private(set) var status = "Choose whether one request should fail, then compare the fetch strategies."
    @Published private(set) var isRunning = false

    private var comparisonTask: Task<Void, Never>?

    func compare(failingID: String?) {
        guard comparisonTask == nil else { return }

        comparison = nil
        isRunning = true
        status = "Fetching four courses sequentially…"

        comparisonTask = Task { [weak self] in
            guard let self else { return }
            defer {
                comparisonTask = nil
                isRunning = false
            }

            let service = CourseDetailsService(
                failingIDs: failingID.map { [$0] } ?? []
            )

            do {
                let sequential = try await service.fetchSequentially(ids: ["A", "B", "C", "D"])
                try Task.checkCancellation()
                status = "Sequential fetch finished. Running the task group…"

                let concurrent = try await service.fetchConcurrently(ids: ["A", "B", "C", "D"])
                comparison = CourseDetailsComparison(
                    sequential: sequential,
                    concurrent: concurrent
                )
                status = "Both strategies finished. Each failed course is shown alongside successful results."
            } catch is CancellationError {
                status = "Comparison cancelled. Child work was cancelled with its parent task."
            } catch {
                status = "Comparison failed: \(error.localizedDescription)"
            }
        }
    }

    func cancel() {
        comparisonTask?.cancel()
    }
}
