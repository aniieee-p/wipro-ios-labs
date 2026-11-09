import Foundation

public struct CounterComparison: Equatable, Sendable {
    public let expectedCount: Int
    public let unsafeCount: Int
    public let safeCount: Int

    public init(expectedCount: Int, unsafeCount: Int, safeCount: Int) {
        self.expectedCount = expectedCount
        self.unsafeCount = unsafeCount
        self.safeCount = safeCount
    }
}

public enum CounterExperiment {
    public static func run(
        taskCount: Int = 100,
        incrementsPerTask: Int = 1_000
    ) async -> CounterComparison {
        precondition(taskCount >= 0)
        precondition(incrementsPerTask >= 0)

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

private final class UnsafeCounter: @unchecked Sendable {
    private var count = 0

    func increment() {
        count += 1
    }

    var value: Int {
        count
    }
}

private actor SafeCounter {
    private var count = 0

    func increment() {
        count += 1
    }

    var value: Int {
        count
    }
}
