import XCTest
@testable import TaskListCore

final class TaskViewModelTests: XCTestCase {
    func testAddTrimsTitleAndRejectsWhitespace() {
        let viewModel = makeViewModel()

        XCTAssertFalse(viewModel.addTask(title: " \n\t "))
        XCTAssertTrue(viewModel.tasks.isEmpty)

        XCTAssertTrue(viewModel.addTask(title: "  Finish lab  "))
        XCTAssertEqual(viewModel.tasks.map(\.title), ["Finish lab"])
    }

    func testToggleChangesCompletionState() {
        let task = TaskItem(title: "Review MVC")
        let viewModel = makeViewModel(tasks: [task])

        XCTAssertTrue(viewModel.toggleTask(id: task.id))
        XCTAssertTrue(viewModel.tasks[0].isCompleted)
        XCTAssertTrue(viewModel.toggleTask(id: task.id))
        XCTAssertFalse(viewModel.tasks[0].isCompleted)
    }

    func testToggleUnknownTaskDoesNotChangeState() {
        let viewModel = makeViewModel()

        XCTAssertFalse(viewModel.toggleTask(id: UUID()))
        XCTAssertTrue(viewModel.tasks.isEmpty)
    }

    func testFilterReturnsOnlyMatchingTasks() {
        let active = TaskItem(title: "Active task")
        let completed = TaskItem(title: "Completed task", isCompleted: true)
        let viewModel = makeViewModel(tasks: [active, completed])

        viewModel.selectedFilter = .active
        XCTAssertEqual(viewModel.visibleTasks, [active])

        viewModel.selectedFilter = .completed
        XCTAssertEqual(viewModel.visibleTasks, [completed])

        viewModel.selectedFilter = .all
        XCTAssertEqual(viewModel.visibleTasks, [active, completed])
    }

    func testDeleteRemovesTaskByIdentifier() {
        let task = TaskItem(title: "Remove me")
        let viewModel = makeViewModel(tasks: [task])

        XCTAssertTrue(viewModel.deleteTask(id: task.id))
        XCTAssertTrue(viewModel.tasks.isEmpty)
        XCTAssertFalse(viewModel.deleteTask(id: task.id))
    }

    private func makeViewModel(tasks: [TaskItem] = []) -> TaskViewModel {
        TaskViewModel(model: TaskListModel(tasks: tasks))
    }
}
