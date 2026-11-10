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
        TaskItem(title: "Review Swift concurrency"),
        TaskItem(title: "Build a task-list screen"),
        TaskItem(title: "Test the view model", isCompleted: true)
    ]
}
