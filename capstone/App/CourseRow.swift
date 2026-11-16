import CoursePlannerCore
import SwiftUI

struct CourseRow: View {
    let course: Course
    let trailingText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(course.title)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
            Text(course.instructor)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            HStack(spacing: 8) {
                Text(course.timeDescription)
                Text("·")
                Text("\(course.credits) credits")
                Text("·")
                Text(trailingText)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
