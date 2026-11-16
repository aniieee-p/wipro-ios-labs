#if canImport(SwiftUI)
import SwiftUI
import TaskListCore

public struct TaskListScreen: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var showError = false

    public init() {}

    public var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Add task row
                HStack(spacing: 12) {
                    TextField("Add a task", text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit(addTask)

                    Button("Add", action: addTask)
                        .buttonStyle(.borderedProminent)
                }

                if showError {
                    Text("Please enter a task title.")
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Filter picker
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    ForEach(TaskFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)

                // Task list
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
                        }
                        .onDelete(perform: deleteTasks)
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("Task List")
            .toolbar {
                EditButton()
            }
        }
    }

    private func addTask() {
        let success = viewModel.addTask(title: newTaskTitle)
        if success {
            newTaskTitle = ""
            showError = false
        } else {
            showError = true
        }
    }

    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            let task = viewModel.visibleTasks[index]
            viewModel.deleteTask(id: task.id)
        }
    }
}
#endif
