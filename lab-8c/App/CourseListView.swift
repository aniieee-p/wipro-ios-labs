import CourseStateCore
import SwiftUI

struct CourseListView: View {
    @ObservedObject var library: CourseLibrary
    @State private var searchText = ""

    private var filteredCourses: [Course] {
        guard !searchText.isEmpty else { return library.courses }
        return library.courses.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.instructor.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredCourses) { course in
                HStack(spacing: 12) {
                    NavigationLink(value: course) {
                        courseRow(course)
                    }
                    FavoriteToggleButton(isFavorite: favoriteBinding(for: course))
                }
                .listRowBackground(Color(uiColor: .secondarySystemGroupedBackground))
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Course Library")
            .searchable(text: $searchText, prompt: "Search courses")
            .overlay {
                if filteredCourses.isEmpty {
                    ContentUnavailableState(searchText: searchText)
                }
            }
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(
                    course: course,
                    isFavorite: favoriteBinding(for: course)
                )
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
        .contentShape(Rectangle())
    }

    private func favoriteBinding(for course: Course) -> Binding<Bool> {
        Binding(
            get: { library.isFavorite(course.id) },
            set: { library.setFavorite($0, for: course.id) }
        )
    }
}
