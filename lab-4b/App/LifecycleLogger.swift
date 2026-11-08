import Combine
import Foundation
import LifecycleCore

@MainActor
final class LifecycleLogger: ObservableObject {
    static let shared = LifecycleLogger()

    @Published private(set) var events: [LifecycleEvent] = []

    private var store = EventLogStore()

    private init() {}

    func record(_ message: String) {
        let event = store.record(message)
        events = store.events
        let timestamp = event.occurredAt.formatted(date: .omitted, time: .standard)
        print("[\(timestamp)] \(message)")
    }
}
