import Foundation

public struct LifecycleEvent: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let occurredAt: Date
    public let message: String

    public init(id: UUID = UUID(), occurredAt: Date = .now, message: String) {
        self.id = id
        self.occurredAt = occurredAt
        self.message = message
    }
}

public struct EventLogStore {
    public private(set) var events: [LifecycleEvent] = []

    public init() {}

    @discardableResult
    public mutating func record(_ message: String, at date: Date = .now) -> LifecycleEvent {
        let event = LifecycleEvent(occurredAt: date, message: message)
        events.append(event)
        return event
    }
}
