#if canImport(Combine)
import Combine
#endif

@MainActor
public final class TaskListViewModel {
    #if canImport(Combine)
    @Published public private(set) var tasks: [TaskItem]
    @Published public var selectedFilter: TaskFilter = .all
    #else
    public private(set) var tasks: [TaskItem]
    public var selectedFilter: TaskFilter = .all
    #endif

    private var model: TaskListModel

    public init(model: TaskListModel = TaskListModel(tasks: TaskItem.samples)) {
        self.model = model
        self.tasks = model.tasks
    }

    public var visibleTasks: [TaskItem] {
        model.filteredTasks(for: selectedFilter)
    }

    @discardableResult
    public func addTask(title: String) -> Bool {
        guard model.addTask(title: title) else { return false }
        tasks = model.tasks
        return true
    }

    @discardableResult
    public func toggleTask(id: TaskItem.ID) -> Bool {
        guard model.toggleTask(id: id) else { return false }
        tasks = model.tasks
        return true
    }

    @discardableResult
    public func deleteTask(id: TaskItem.ID) -> Bool {
        guard model.deleteTask(id: id) else { return false }
        tasks = model.tasks
        return true
    }
}

#if canImport(Combine)
extension TaskListViewModel: ObservableObject {}
#endif
