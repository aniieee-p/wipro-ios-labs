import CourseNavigationCore
import SwiftUI

struct CourseListView: View {
    @State private var path: [CourseNavigationRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            List(Course.samples) { course in
                NavigationLink(value: CourseNavigationRoute.course(course)) {
                    courseRow(course)
                }
                .accessibilityHint("Opens course details")
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Courses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        path.append(.about)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .accessibilityLabel("About navigation")
                }
            }
            .navigationDestination(for: CourseNavigationRoute.self) { route in
                switch route {
                case let .course(course):
                    CourseDetailView(course: course) {
                        path.removeAll()
                    }
                case .about:
                    AboutNavigationView()
                }
            }
        }
    }

    private func courseRow(_ course: Course) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(course.title)
                .font(.headline)
            Text(course.instructor)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(course.duration)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    CourseListView()
}
