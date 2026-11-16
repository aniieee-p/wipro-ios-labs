import CoursePlannerCore
import SwiftUI

struct PlannerHomeView: View {
    @ObservedObject var viewModel: CoursePlannerViewModel

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Plan a week that works.")
                        .font(.largeTitle.bold())
                        .fixedSize(horizontal: false, vertical: true)
                    Text("Build a balanced course schedule and keep an eye on time conflicts and credits.")
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    creditSummary
                }
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .listRowBackground(Color.clear)
            }

            Section("Your planner") {
                NavigationLink {
                    CourseCatalogView(viewModel: viewModel)
                } label: {
                    Label("Explore course catalog", systemImage: "books.vertical")
                }

                NavigationLink {
                    CourseScheduleView(viewModel: viewModel)
                } label: {
                    Label("View weekly schedule", systemImage: "calendar")
                }
            }

            Section("Planned courses") {
                if viewModel.planner.plannedCourses.isEmpty {
                    PlannerEmptyState(
                        title: "No courses planned",
                        systemImage: "calendar.badge.plus",
                        message: "Explore the catalog and add a course to start your plan."
                    )
                    .listRowBackground(Color.clear)
                } else {
                    ForEach(viewModel.planner.plannedCourses) { course in
                        NavigationLink(value: PlannerRoute.course(course.id)) {
                            CourseRow(course: course, trailingText: "\(course.credits) credits")
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Course Planner")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var creditSummary: some View {
        HStack(spacing: 0) {
            CreditMetric(title: "Planned", value: "\(viewModel.planner.totalCredits)")
            Divider().frame(height: 40)
            CreditMetric(title: "Available", value: "\(viewModel.planner.remainingCredits)")
            Divider().frame(height: 40)
            CreditMetric(title: "Limit", value: "\(viewModel.planner.creditLimit)")
        }
        .padding(.vertical, 12)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
    }
}

private struct CreditMetric: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
