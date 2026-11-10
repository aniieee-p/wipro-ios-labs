import Foundation

public struct TaskListModel: Sendable {
    public private(set) var tasks: [TaskItem]

    public init(tasks: [TaskItem] = []) {
        self.tasks = tasks
    }

    @discardableResult
    public mutating func addTask(title: String) -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return false }
        tasks.append(TaskItem(title: trimmedTitle))
        return true
    }

    @discardableResult
    public mutating func toggleTask(id: TaskItem.ID) -> Bool {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return false }
        tasks[index].isCompleted.toggle()
        return true
    }

    @discardableResult
    public mutating func deleteTask(id: TaskItem.ID) -> Bool {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return false }
        tasks.remove(at: index)
        return true
    }

    public func filteredTasks(for filter: TaskFilter) -> [TaskItem] {
        switch filter {
        case .all:
            tasks
        case .active:
            tasks.filter { !$0.isCompleted }
        case .completed:
            tasks.filter(\.isCompleted)
        }
    }
}
