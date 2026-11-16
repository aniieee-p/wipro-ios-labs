import Foundation

public struct TaskListModel {
    public var tasks: [TaskItem]

    public init(tasks: [TaskItem] = []) {
        self.tasks = tasks
    }

    public mutating func addTask(title: String) -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedTitle.isEmpty {
            return false
        }
        tasks.append(TaskItem(title: trimmedTitle))
        return true
    }

    public mutating func toggleTask(id: UUID) -> Bool {
        for i in 0..<tasks.count {
            if tasks[i].id == id {
                tasks[i].isCompleted.toggle()
                return true
            }
        }
        return false
    }

    public mutating func deleteTask(id: UUID) -> Bool {
        for i in 0..<tasks.count {
            if tasks[i].id == id {
                tasks.remove(at: i)
                return true
            }
        }
        return false
    }

    public func filteredTasks(for filter: TaskFilter) -> [TaskItem] {
        switch filter {
        case .all:
            return tasks
        case .active:
            var result: [TaskItem] = []
            for task in tasks {
                if !task.isCompleted {
                    result.append(task)
                }
            }
            return result
        case .completed:
            var result: [TaskItem] = []
            for task in tasks {
                if task.isCompleted {
                    result.append(task)
                }
            }
            return result
        }
    }
}
