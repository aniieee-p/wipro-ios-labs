import SwiftUI

struct ExplorerHeader: View {
    let courseCount: Int

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.indigo, .blue, .cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            Circle()
                .fill(.white.opacity(0.12))
                .frame(width: 150, height: 150)
                .offset(x: 230, y: -56)
            VStack(alignment: .leading, spacing: 10) {
                Label("LEARN AT YOUR PACE", systemImage: "sparkles")
                    .font(.caption.weight(.bold))
                    .tracking(1.2)
                    .foregroundStyle(.white.opacity(0.85))
                Text("Make room\nfor what’s next.")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                Text("\(courseCount) thoughtfully designed courses")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.88))
            }
            .padding(22)
        }
        .frame(height: 208)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}
