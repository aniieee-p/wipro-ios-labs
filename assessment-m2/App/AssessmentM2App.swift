import MilestoneCore
import SwiftUI

@main
struct AssessmentM2App: App {
    var body: some Scene {
        WindowGroup {
            AssessmentScreen()
        }
    }
}

@MainActor
private struct AssessmentScreen: View {
    @StateObject private var taskModel = TaskListViewModel()
    @StateObject private var dashboardModel = DashboardViewModel()
    @State private var newTaskTitle = ""
    @State private var shouldSimulateFailure = false

    var body: some View {
        NavigationStack {
            List {
                Section("Concurrent dashboard") {
                    Toggle("Simulate service error", isOn: $shouldSimulateFailure)
                        .disabled(isLoading)

                    dashboardContent

                    if isLoading {
                        Button("Cancel loading", role: .destructive) {
                            dashboardModel.cancel()
                        }
                    } else {
                        Button("Load courses and announcements") {
                            dashboardModel.load(
                                failingSource: shouldSimulateFailure ? .courses : nil
                            )
                        }
                    }
                }

                Section("MVVM task list") {
                    HStack {
                        TextField("New task", text: $newTaskTitle)
                            .accessibilityLabel("New task title")
                        Button("Add", action: addTask)
                            .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }

                    Picker("Filter", selection: $taskModel.selectedFilter) {
                        ForEach(TaskFilter.allCases) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(.segmented)

                    ForEach(taskModel.visibleTasks) { task in
                        Button {
                            taskModel.toggleTask(id: task.id)
                        } label: {
                            Label(task.title, systemImage: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .strikethrough(task.isCompleted)
                        }
                        .tint(task.isCompleted ? .green : .primary)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                taskModel.deleteTask(id: task.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Milestone 2")
        }
    }

    @ViewBuilder
    private var dashboardContent: some View {
        switch dashboardModel.state {
        case .idle:
            Text("Two independent sources load concurrently.")
                .foregroundStyle(.secondary)
        case .loading:
            ProgressView("Loading both sources…")
        case .success(let dashboard):
            ForEach(dashboard.courses) { course in
                Label("\(course.title) · \(course.instructor)", systemImage: "book")
            }
            ForEach(dashboard.announcements) { announcement in
                Label(announcement.message, systemImage: "megaphone")
            }
        case .failure(let message):
            Label(message, systemImage: "exclamationmark.triangle")
                .foregroundStyle(.red)
        case .cancelled:
            Label("Loading cancelled.", systemImage: "xmark.circle")
                .foregroundStyle(.secondary)
        }
    }

    private var isLoading: Bool {
        if case .loading = dashboardModel.state { return true }
        return false
    }

    private func addTask() {
        if taskModel.addTask(title: newTaskTitle) {
            newTaskTitle = ""
        }
    }
}
