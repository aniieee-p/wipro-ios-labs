import CourseExplorerCore
import SwiftUI

struct CourseCard: View {
    let title: String
    let subtitle: String
    let status: CourseStatus
    let category: String
    let symbol: String

    init(course: Course) {
        title = course.title
        subtitle = course.subtitle
        status = course.status
        category = course.category
        symbol = course.symbol
    }

    init(title: String, subtitle: String, status: CourseStatus) {
        self.title = title
        self.subtitle = subtitle
        self.status = status
        self.category = "Course"
        self.symbol = "book.closed"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(tint.opacity(0.13))
                Image(systemName: symbol)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(tint)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .accessibilityHidden(true)
                Text(category.uppercased())
                    .font(.system(size: 9, weight: .bold))
                    .tracking(0.5)
                    .foregroundStyle(tint)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.background.opacity(0.92), in: Capsule())
                    .padding(8)
            }
            .frame(height: 92)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            Spacer(minLength: 0)
            StatusBadge(status: status)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 220, alignment: .leading)
        .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(.quaternary, lineWidth: 1)
        }
        .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var tint: Color {
        switch category {
        case "Swift": .orange
        case "Design": .purple
        case "Networking": .blue
        case "Concurrency": .green
        default: .indigo
        }
    }
}
