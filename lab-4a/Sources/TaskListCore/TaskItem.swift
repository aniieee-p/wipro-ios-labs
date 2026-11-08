import Foundation

public struct TaskItem: Identifiable, Equatable, Hashable, Sendable {
    public let id: UUID
    public var title: String
    public var isCompleted: Bool

    public init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }

    public static let samples = [
        TaskItem(title: "Review Swift value types"),
        TaskItem(title: "Build the task-list screen"),
        TaskItem(title: "Write view-model tests", isCompleted: true)
    ]
}
