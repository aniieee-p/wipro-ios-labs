import Foundation

public struct WorkResult: Equatable, Sendable {
    public let name: String
    public let detail: String

    public init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

public final class ParallelWorkCoordinator: Sendable {
    public init() {}

    public func run(
        completion: @escaping @MainActor @Sendable ([WorkResult]) -> Void
    ) {
        let group = DispatchGroup()
        let collector = ResultCollector()
        let operations: [(name: String, delay: TimeInterval)] = [
            ("Profile", 1.5),
            ("Messages", 2.0)
        ]

        for operation in operations {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).asyncAfter(
                deadline: .now() + operation.delay
            ) {
                let result = WorkResult(
                    name: operation.name,
                    detail: "\(operation.name) data loaded after \(operation.delay) seconds."
                )
                collector.append(result)
                log("Finished \(operation.name) operation", queue: "global(qos: .userInitiated)")
                group.leave()
            }
        }

        group.notify(queue: .global(qos: .userInitiated)) {
            let results = collector.results
            DispatchQueue.main.async {
                log("Delivering \(results.count) results", queue: "main")
                completion(results)
            }
        }

        log("Scheduled \(operations.count) independent operations", queue: "global.asyncAfter")
    }
}

private final class ResultCollector: @unchecked Sendable {
    private let lock = NSLock()
    private var storedResults: [WorkResult] = []

    func append(_ result: WorkResult) {
        lock.lock()
        storedResults.append(result)
        lock.unlock()
    }

    var results: [WorkResult] {
        lock.lock()
        defer { lock.unlock() }
        return storedResults.sorted { $0.name < $1.name }
    }
}

private func log(_ message: String, queue: String) {
    let thread = Thread.isMainThread ? "main-thread" : "background-thread"
    print("[GCD Lab] queue=\(queue) thread=\(thread) \(message)")
}
