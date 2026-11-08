#if canImport(Combine)
import Combine
#endif

public final class TaskViewModel {
    #if canImport(Combine)
    @Published public private(set) var tasks: [TaskItem]
    @Published public var selectedFilter: TaskFilter = .all
    #else
    public private(set) var tasks: [TaskItem]
    public var selectedFilter: TaskFilter = .all
    #endif

    private let model: TaskListModel

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
        refreshTasks()
        return true
    }

    @discardableResult
    public func toggleTask(id: TaskItem.ID) -> Bool {
        guard model.toggleTask(id: id) else { return false }
        refreshTasks()
        return true
    }

    @discardableResult
    public func deleteTask(id: TaskItem.ID) -> Bool {
        guard model.deleteTask(id: id) else { return false }
        refreshTasks()
        return true
    }

    private func refreshTasks() {
        tasks = model.tasks
    }
}

#if canImport(Combine)
extension TaskViewModel: ObservableObject {}
#endif
