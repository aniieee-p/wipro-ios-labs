import CourseNavigationCore
import SwiftUI

struct CourseDetailView: View {
    let course: Course
    let returnToRoot: () -> Void

    var body: some View {
        Form {
            Section("Course") {
                LabeledContent("Title", value: course.title)
                LabeledContent("Instructor", value: course.instructor)
                LabeledContent("Duration", value: course.duration)
            }

            Section("About this course") {
                Text(course.summary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: returnToRoot) {
                    Label("Courses", systemImage: "list.bullet")
                }
                .accessibilityHint("Returns to the course list")
            }
        }
    }
}
