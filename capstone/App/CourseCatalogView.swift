import CoursePlannerCore
import SwiftUI

struct CourseCatalogView: View {
    @ObservedObject var viewModel: CoursePlannerViewModel

    var body: some View {
        Group {
            switch viewModel.catalogState {
            case .idle:
                ProgressView("Loading courses")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .failed(let message):
                ContentUnavailableView {
                    Label("Couldn't load courses", systemImage: "exclamationmark.triangle")
                } description: {
                    Text(message)
                } actions: {
                    Button("Try again") {
                        viewModel.loadCatalog()
                    }
                }
            case .empty:
                PlannerEmptyState(
                    title: "No courses available",
                    systemImage: "books.vertical",
                    message: "The catalog is empty right now."
                )
            case .loaded:
                catalogList
            }
        }
        .navigationTitle("Course Catalog")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var catalogList: some View {
        List {
            Section {
                Text("Choose courses that fit your week. Overlapping classes and plans over \(viewModel.planner.creditLimit) credits are rejected.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Section("Available courses") {
                if viewModel.visibleCourses.isEmpty {
                    PlannerEmptyState(
                        title: "No matching courses",
                        systemImage: "magnifyingglass",
                        message: "Try a different title, instructor, or category."
                    )
                } else {
                    ForEach(viewModel.visibleCourses) { course in
                        HStack(spacing: 12) {
                            NavigationLink(value: PlannerRoute.course(course.id)) {
                                CourseRow(course: course, trailingText: course.category)
                            }
                            Button {
                                viewModel.addCourse(id: course.id)
                            } label: {
                                Image(systemName: viewModel.planner.plannedCourseIDs.contains(course.id) ? "checkmark.circle.fill" : "plus.circle")
                                    .font(.title2)
                                    .foregroundStyle(viewModel.planner.plannedCourseIDs.contains(course.id) ? .green : .tint)
                                    .frame(width: 44, height: 44)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .disabled(viewModel.planner.plannedCourseIDs.contains(course.id))
                            .accessibilityLabel(
                                viewModel.planner.plannedCourseIDs.contains(course.id)
                                    ? "\(course.title) already planned"
                                    : "Add \(course.title)"
                            )
                        }
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Course, instructor, or category")
    }
}
