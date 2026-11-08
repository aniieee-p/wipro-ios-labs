import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var logger: LifecycleLogger
    @State private var refreshedAt = Date.now
    @State private var refreshCount = 0

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "arrow.clockwise.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(.blue)

            Text("Detail screen")
                .font(.largeTitle.bold())

            Text("Lightweight refreshes: \(refreshCount)")
                .font(.headline)

            Text("Last refreshed: \(refreshedAt.formatted(date: .omitted, time: .standard))")
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            refreshLightweightContent()
            logger.record("View: Detail onAppear")
        }
        .onDisappear {
            logger.record("View: Detail onDisappear")
        }
    }

    private func refreshLightweightContent() {
        refreshedAt = .now
        refreshCount += 1
        logger.record("Refresh: Detail timestamp updated")
    }
}
