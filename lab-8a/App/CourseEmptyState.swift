import SwiftUI

struct CourseEmptyState: View {
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "books.vertical")
                .font(.system(size: 42))
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
            Text("No courses yet")
                .font(.title2.bold())
            Text("New learning paths will appear here when they’re available.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 280)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .accessibilityElement(children: .combine)
    }
}
