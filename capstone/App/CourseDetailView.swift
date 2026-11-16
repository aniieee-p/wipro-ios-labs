import CoursePlannerCore
import SwiftUI

struct CourseDetailView: View {
    let course: Course
    @ObservedObject var viewModel: CoursePlannerViewModel

    private var isPlanned: Bool {
        viewModel.planner.plannedCourseIDs.contains(course.id)
    }

    var body: some View {
        Form {
            Section("Course details") {
                LabeledContent("Instructor", value: course.instructor)
                LabeledContent("Category", value: course.category)
                LabeledContent("Credits", value: "\(course.credits)")
                LabeledContent("Schedule", value: course.timeDescription)
            }

            Section("About") {
                Text(course.summary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Section {
                Button {
                    if isPlanned {
                        viewModel.removeCourse(id: course.id)
                    } else {
                        viewModel.addCourse(id: course.id)
                    }
                } label: {
                    Label(
                        isPlanned ? "Remove from plan" : "Add to plan",
                        systemImage: isPlanned ? "minus.circle" : "plus.circle"
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .accessibilityIdentifier("course.planAction")
            } footer: {
                Text("The planner prevents schedule conflicts and enforces a \(viewModel.planner.creditLimit)-credit limit.")
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
