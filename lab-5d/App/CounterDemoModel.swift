import Combine
import ConcurrencySafetyCore
import Foundation

@MainActor
final class CounterDemoModel: ObservableObject {
    @Published private(set) var result: CounterComparison?
    @Published private(set) var isRunning = false
    @Published private(set) var message = "Run the experiment to compare a shared mutable counter with an actor."

    func runExperiment() {
        guard !isRunning else { return }
        isRunning = true
        result = nil
        message = "Running 100 tasks × 1,000 increments for each counter…"

        Task {
            let comparison = await CounterExperiment.run()
            result = comparison
            isRunning = false
            message = comparison.unsafeCount == comparison.expectedCount
                ? "This run did not expose a lost update; the shared counter is still unsafe."
                : "The unsafe counter lost updates. The actor-protected count is exact."
        }
    }
}
