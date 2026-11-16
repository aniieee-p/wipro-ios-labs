
import Foundation

// Holds the result of one background operation
public struct WorkResult: Sendable {
    public let name: String
    public let detail: String

    public init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

// Runs two background tasks in parallel using GCD
public class ParallelWorkCoordinator {
    public init() {}

    public func run(completion: @escaping ([WorkResult]) -> Void) {
        let group = DispatchGroup()
        let results = ResultsStorage()

        // Task 1: Profile
        group.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            let result = WorkResult(
                name: "Profile",
                detail: "Profile data loaded after 1.5 seconds."
            )

            results.add(result)
            print("[GCD] Profile finished on background thread")
            group.leave()
        }

        // Task 2: Messages
        group.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let result = WorkResult(
                name: "Messages",
                detail: "Messages data loaded after 2.0 seconds."
            )

            results.add(result)
            print("[GCD] Messages finished on background thread")
            group.leave()
        }

        group.notify(queue: .main) {
            let sorted = results.getAll().sorted { $0.name < $1.name }
            print("[GCD] Delivering \(sorted.count) results on main thread")
            completion(sorted)
        }

        print("[GCD] Scheduled 2 parallel operations")
    }
}

// Safely stores results using a lock
private final class ResultsStorage: @unchecked Sendable {
    private let lock = NSLock()
    private var results: [WorkResult] = []

    func add(_ result: WorkResult) {
        lock.lock()
        results.append(result)
        lock.unlock()
    }

    func getAll() -> [WorkResult] {
        lock.lock()
        defer { lock.unlock() }
        return results
    }
}
