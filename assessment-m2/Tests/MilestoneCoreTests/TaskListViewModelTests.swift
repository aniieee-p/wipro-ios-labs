import XCTest
@testable import MilestoneCore

@MainActor
final class TaskListViewModelTests: XCTestCase {
    func testAddTrimsTitleAndRejectsBlankInput() {
        let viewModel = TaskListViewModel(model: TaskListModel())

        XCTAssertTrue(viewModel.addTask(title: "  Prepare demo  "))
        XCTAssertEqual(viewModel.tasks.map(\.title), ["Prepare demo"])
        XCTAssertFalse(viewModel.addTask(title: "  "))
        XCTAssertEqual(viewModel.tasks.count, 1)
    }

    func testToggleFilterAndDeleteUpdateVisibleTasks() {
        let first = TaskItem(title: "Active task")
        let second = TaskItem(title: "Finished task", isCompleted: true)
        let viewModel = TaskListViewModel(model: TaskListModel(tasks: [first, second]))

        viewModel.selectedFilter = .active
        XCTAssertEqual(viewModel.visibleTasks, [first])

        XCTAssertTrue(viewModel.toggleTask(id: first.id))
        viewModel.selectedFilter = .completed
        XCTAssertEqual(Set(viewModel.visibleTasks), Set([first, second]))

        XCTAssertTrue(viewModel.deleteTask(id: first.id))
        XCTAssertEqual(viewModel.tasks, [second])
    }
}
