import CourseStateCore
import SwiftUI

struct CourseDetailView: View {
    let course: Course
    @Binding var isFavorite: Bool

    var body: some View {
        Form {
            Section("Course") {
                LabeledContent("Instructor", value: course.instructor)
                LabeledContent("Duration", value: course.duration)
            }

            Section("About this course") {
                Text(course.summary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Section {
                FavoriteToggleButton(isFavorite: $isFavorite, prominent: true)
            }
        }
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
