
import Foundation

#if canImport(Combine)
import Combine
#else
public protocol ObservableObject: AnyObject {}

@propertyWrapper
public struct Published<Value> {
    public var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
#endif

@MainActor
public final class TaskListViewModel: ObservableObject {
    @Published public var tasks: [TaskItem]
    @Published public var selectedFilter: TaskFilter = .all

    private var model: TaskListModel

    public init(model: TaskListModel = TaskListModel(tasks: TaskItem.samples)) {
        self.model = model
        self.tasks = model.tasks
    }

    public var visibleTasks: [TaskItem] {
        model.filteredTasks(for: selectedFilter)
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
