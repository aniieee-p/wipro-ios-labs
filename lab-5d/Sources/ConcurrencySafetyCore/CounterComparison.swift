
import Foundation

// Holds the results of the unsafe vs safe counter experiment
public struct CounterComparison: Equatable, Sendable {
    public let expectedCount: Int
    public let unsafeCount: Int
    public let safeCount: Int

    public init(
        expectedCount: Int,
        unsafeCount: Int,
        safeCount: Int
    ) {
        self.expectedCount = expectedCount
        self.unsafeCount = unsafeCount
        self.safeCount = safeCount
    }
}

// Runs both an unsafe and a safe counter with multiple concurrent tasks
public enum CounterExperiment {
    public static func run(
        taskCount: Int = 100,
        incrementsPerTask: Int = 1_000
    ) async -> CounterComparison {

        // Unsafe counter: may lose updates due to data race
        let unsafeCounter = UnsafeCounter()

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<taskCount {
                group.addTask {
                    for _ in 0..<incrementsPerTask {
                        unsafeCounter.increment()
                    }
                }
            }
        }

        // Safe counter: uses an actor so updates never clash
        let safeCounter = SafeCounter()

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<taskCount {
                group.addTask {
                    for _ in 0..<incrementsPerTask {
                        await safeCounter.increment()
                    }
                }
            }
        }

        return CounterComparison(
            expectedCount: taskCount * incrementsPerTask,
            unsafeCount: unsafeCounter.value,
            safeCount: await safeCounter.value
        )
    }
}

// Not thread-safe — may produce wrong counts
private final class UnsafeCounter: @unchecked Sendable {
    var count = 0

    func increment() {
        count += 1
    }

    var value: Int {
        count
    }
}

// Thread-safe — actor serializes all access
private actor SafeCounter {
    private var count = 0

    func increment() {
        count += 1
    }

    var value: Int {
        count
    }
}
