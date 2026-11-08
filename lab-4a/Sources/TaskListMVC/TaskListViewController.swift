#if canImport(UIKit)
import UIKit
import TaskListCore

public final class TaskListViewController: UIViewController {
    private let taskListView = TaskListView()
    private let model = TaskListModel(tasks: TaskItem.samples)
    private var selectedFilter: TaskFilter = .all

    public override func loadView() {
        view = taskListView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "MVC Task List"
        taskListView.tableView.dataSource = self
        taskListView.tableView.delegate = self
        taskListView.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "TaskCell"
        )
        taskListView.addButton.addTarget(
            self,
            action: #selector(addTask),
            for: .touchUpInside
        )
        taskListView.taskInputField.addTarget(
            self,
            action: #selector(addTask),
            for: .editingDidEndOnExit
        )
        taskListView.filterControl.addTarget(
            self,
            action: #selector(filterChanged),
            for: .valueChanged
        )
        render()
    }

    @objc private func addTask() {
        guard model.addTask(title: taskListView.taskInputField.text ?? "") else {
            taskListView.validationLabel.isHidden = false
            return
        }

        taskListView.taskInputField.text = ""
        taskListView.validationLabel.isHidden = true
        render()
    }

    @objc private func filterChanged() {
        selectedFilter = TaskFilter.allCases[taskListView.filterControl.selectedSegmentIndex]
        render()
    }

    private func render() {
        taskListView.tableView.reloadData()
        taskListView.emptyLabel.isHidden = !model.filteredTasks(for: selectedFilter).isEmpty
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.filteredTasks(for: selectedFilter).count
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let task = model.filteredTasks(for: selectedFilter)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        content.textProperties.color = task.isCompleted ? .secondaryLabel : .label
        content.textProperties.strikethroughStyle = task.isCompleted ? .single : []
        cell.contentConfiguration = content
        cell.accessoryType = task.isCompleted ? .checkmark : .none
        cell.accessibilityLabel = task.title
        cell.accessibilityValue = task.isCompleted ? "Completed" : "Active"
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = model.filteredTasks(for: selectedFilter)[indexPath.row]
        model.toggleTask(id: task.id)
        tableView.deselectRow(at: indexPath, animated: true)
        render()
    }

    public func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        let task = model.filteredTasks(for: selectedFilter)[indexPath.row]
        model.deleteTask(id: task.id)
        render()
    }
}
#endif
