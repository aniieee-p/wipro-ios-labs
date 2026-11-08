#if canImport(SwiftUI)
import SwiftUI
import TaskListCore

public struct TaskListScreen: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var validationMessage: String?

    public init() {}

    public var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    TextField("Add a task", text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Task title")
                        .onSubmit(addTask)

                    Button("Add", action: addTask)
                        .buttonStyle(.borderedProminent)
                }

                if let validationMessage {
                    Text(validationMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Picker("Filter", selection: $viewModel.selectedFilter) {
                    ForEach(TaskFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)

                if viewModel.visibleTasks.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "checklist")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("No tasks")
                            .font(.headline)
                        Text("Add a task or choose a different filter.")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.visibleTasks) { task in
                            Button {
                                viewModel.toggleTask(id: task.id)
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: task.isCompleted
                                          ? "checkmark.circle.fill"
                                          : "circle")
                                        .foregroundStyle(
                                            task.isCompleted ? Color.green : Color.gray
                                        )
                                    Text(task.title)
                                        .strikethrough(task.isCompleted)
                                        .foregroundStyle(
                                            task.isCompleted ? Color.gray : Color.primary
                                        )
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .accessibilityValue(task.isCompleted ? "Completed" : "Active")
                        }
                        .onDelete(perform: deleteTasks)
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("MVVM Task List")
            .toolbar {
                EditButton()
            }
        }
    }

    private func addTask() {
        guard viewModel.addTask(title: newTaskTitle) else {
            validationMessage = "Enter a non-empty task title."
            return
        }

        newTaskTitle = ""
        validationMessage = nil
    }

    private func deleteTasks(at offsets: IndexSet) {
        let tasksToDelete = offsets.map { viewModel.visibleTasks[$0] }
        tasksToDelete.forEach { viewModel.deleteTask(id: $0.id) }
    }
}
#endif
