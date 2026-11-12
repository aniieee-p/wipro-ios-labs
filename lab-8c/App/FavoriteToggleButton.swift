import SwiftUI

struct FavoriteToggleButton: View {
    @Binding var isFavorite: Bool
    var prominent = false

    var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            label
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
    }

    @ViewBuilder
    private var label: some View {
        if prominent {
            Label(
                isFavorite ? "Remove Favorite" : "Add Favorite",
                systemImage: isFavorite ? "heart.fill" : "heart"
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(Color.accentColor, in: Capsule())
            .foregroundStyle(.white)
        } else {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? Color.red : Color.secondary)
                .frame(width: 40, height: 40)
                .contentShape(Rectangle())
        }
    }
}
