import CoursePlannerCore
import SwiftUI

struct CourseScheduleView: View {
    @ObservedObject var viewModel: CoursePlannerViewModel

    private var weekdays: [Int] {
        Array(Set(viewModel.planner.plannedCourses.map(\.weekday))).sorted()
    }

    var body: some View {
        Group {
            if viewModel.planner.plannedCourses.isEmpty {
                PlannerEmptyState(
                    title: "Your week is open",
                    systemImage: "calendar",
                    message: "Add courses from the catalog to see them here."
                )
            } else {
                List {
                    Section {
                        Label(
                            "\(viewModel.planner.totalCredits) of \(viewModel.planner.creditLimit) credits planned",
                            systemImage: "checkmark.circle"
                        )
                    }

                    ForEach(weekdays, id: \.self) { weekday in
                        Section(Course.weekdayName(weekday)) {
                            ForEach(viewModel.planner.plannedCourses.filter { $0.weekday == weekday }) { course in
                                NavigationLink {
                                    CourseDetailView(course: course, viewModel: viewModel)
                                } label: {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(course.title)
                                            .font(.headline)
                                        Text("\(course.timeDescription) · \(course.credits) credits")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                            .onDelete { offsets in
                                let courses = viewModel.planner.plannedCourses.filter { $0.weekday == weekday }
                                let courseIDs = offsets.map { courses[$0].id }
                                for courseID in courseIDs {
                                    viewModel.removeCourse(id: courseID)
                                }
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Weekly Schedule")
        .navigationBarTitleDisplayMode(.inline)
    }
}
