import Foundation

public final class TaskListModel {
    public private(set) var tasks: [TaskItem]

    public init(tasks: [TaskItem] = []) {
        self.tasks = tasks
    }

    @discardableResult
    public func addTask(title: String) -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return false }

        tasks.append(TaskItem(title: trimmedTitle))
        return true
    }

    @discardableResult
    public func toggleTask(id: TaskItem.ID) -> Bool {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            return false
        }

        tasks[index].isCompleted.toggle()
        return true
    }

    @discardableResult
    public func deleteTask(id: TaskItem.ID) -> Bool {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            return false
        }

        tasks.remove(at: index)
        return true
    }

    public func filteredTasks(for filter: TaskFilter) -> [TaskItem] {
        switch filter {
        case .all:
            return tasks
        case .active:
            return tasks.filter { !$0.isCompleted }
        case .completed:
            return tasks.filter(\.isCompleted)
        }
    }
}
