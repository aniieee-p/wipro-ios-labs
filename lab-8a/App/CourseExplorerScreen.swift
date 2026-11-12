import CourseExplorerCore
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

struct CourseExplorerScreen: View {
    let courses: [Course]

    init(courses: [Course] = Course.samples) {
        self.courses = courses
    }

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    private var categories: [String] {
        Array(Set(courses.map(\.category))).sorted()
    }

    var body: some View {
        NavigationStack {
            Group {
                if courses.isEmpty {
                    CourseEmptyState()
                } else {
                    courseContent
                }
            }
            .background(backgroundColor)
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var courseContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                ExplorerHeader(courseCount: courses.count)
                categorySection
                featuredSection
            }
            .padding(.horizontal, 18)
            .padding(.top, 8)
            .padding(.bottom, 28)
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeading(title: "Browse categories", subtitle: "Find your next topic")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(categories, id: \.self) { category in
                        CategoryPill(title: category)
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }

    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeading(title: "Your courses", subtitle: "Small steps, steady progress")
            LazyVGrid(columns: columns, alignment: .center, spacing: 14) {
                ForEach(courses) { course in
                    NavigationLink(value: course) {
                        CourseCard(course: course)
                    }
                    .buttonStyle(.plain)
                    .accessibilityHint("Opens course details")
                }
            }
            .navigationDestination(for: Course.self) { course in
                CourseDetailScreen(course: course)
            }
        }
    }

    private var backgroundColor: Color {
        #if canImport(UIKit)
        Color(uiColor: .systemGroupedBackground)
        #else
        Color.gray.opacity(0.08)
        #endif
    }
}

#Preview("Course Explorer") {
    CourseExplorerScreen()
}

#Preview("Empty state") {
    CourseExplorerScreen(courses: [])
}
