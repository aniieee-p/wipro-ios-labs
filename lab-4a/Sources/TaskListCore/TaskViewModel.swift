import Combine

// ViewModel for the task list screen
public final class TaskViewModel: ObservableObject {
    @Published public var tasks: [TaskItem]
    @Published public var selectedFilter: TaskFilter = .all

    private let model: TaskListModel

    public init(model: TaskListModel = TaskListModel(tasks: TaskItem.samples)) {
        self.model = model
        self.tasks = model.tasks
    }

    // Returns only the tasks matching the selected filter
    public var visibleTasks: [TaskItem] {
        return model.filteredTasks(for: selectedFilter)
    }

    public func addTask(title: String) -> Bool {
        let success = model.addTask(title: title)
        if success {
            tasks = model.tasks
        }
        return success
    }

    public func toggleTask(id: UUID) -> Bool {
        let success = model.toggleTask(id: id)
        if success {
            tasks = model.tasks
        }
        return success
    }

    public func deleteTask(id: UUID) -> Bool {
        let success = model.deleteTask(id: id)
        if success {
            tasks = model.tasks
        }
        return success
    }
}
