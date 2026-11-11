import Foundation

@MainActor
final class LifecycleLogStore {
    static let shared = LifecycleLogStore()
    private(set) var entries: [String] = []

    private init() {}

    func record(_ event: String) {
        let timestamp = Date.now.formatted(date: .omitted, time: .standard)
        let entry = "[\(timestamp)] \(event)"
        entries.append(entry)
        print("[Lab 7C] \(entry)")
    }
}
