import CourseExplorerCore
import SwiftUI

struct StatusBadge: View {
    let status: CourseStatus

    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(color)
                .frame(width: 6, height: 6)
            Text(status.rawValue)
                .font(.caption2.weight(.semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .foregroundStyle(color)
        .padding(.horizontal, 9)
        .padding(.vertical, 6)
        .background(color.opacity(0.1), in: Capsule())
        .accessibilityElement(children: .combine)
    }

    private var color: Color {
        switch status {
        case .inProgress: .blue
        case .new: .orange
        case .completed: .green
        }
    }
}
