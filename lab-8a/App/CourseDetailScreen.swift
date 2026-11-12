import CourseExplorerCore
import SwiftUI

struct CourseDetailScreen: View {
    let course: Course

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                artwork
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 7) {
                        Text(course.title)
                            .font(.largeTitle.bold())
                            .fixedSize(horizontal: false, vertical: true)
                        Text(course.subtitle)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                    Spacer(minLength: 0)
                    StatusBadge(status: course.status)
                }
                details
                Text(course.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Button(action: {}) {
                    Label("Start learning", systemImage: "arrow.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .accessibilityHint("Course enrollment is not part of this demo")
            }
            .padding(20)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Course")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var artwork: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(.indigo.gradient)
            Image(systemName: course.symbol)
                .font(.system(size: 64, weight: .medium))
                .foregroundStyle(.white)
        }
        .frame(height: 210)
        .accessibilityHidden(true)
    }

    private var details: some View {
        HStack(spacing: 12) {
            Label(course.category, systemImage: "tag")
            Spacer()
            Label(course.duration, systemImage: "clock")
        }
        .font(.subheadline.weight(.medium))
        .foregroundStyle(.secondary)
        .padding(14)
        .background(.background, in: RoundedRectangle(cornerRadius: 14))
    }
}
