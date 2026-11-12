import SwiftUI

struct CategoryPill: View {
    let title: String

    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: icon)
                .font(.caption.weight(.semibold))
            Text(title)
                .font(.subheadline.weight(.medium))
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 13)
        .padding(.vertical, 9)
        .background(.background, in: Capsule())
        .overlay {
            Capsule().strokeBorder(.quaternary, lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
    }

    private var icon: String {
        switch title {
        case "Swift": "swift"
        case "Design": "paintpalette"
        case "Networking": "network"
        case "Concurrency": "arrow.triangle.2.circlepath"
        default: "tag"
        }
    }
}
