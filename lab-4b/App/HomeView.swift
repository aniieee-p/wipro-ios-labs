import SwiftUI
import LifecycleCore

struct HomeView: View {
    @EnvironmentObject private var logger: LifecycleLogger

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Label("Lifecycle Lab", systemImage: "point.3.connected.trianglepath.dotted")
                    .font(.largeTitle.bold())

                Text("Open the detail screen, return, or background the app and watch the lifecycle events.")
                    .foregroundStyle(.secondary)

                NavigationLink {
                    DetailView()
                } label: {
                    Label("Open detail screen", systemImage: "arrow.right.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                eventLog
            }
            .padding()
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                logger.record("View: Home onAppear")
            }
            .onDisappear {
                logger.record("View: Home onDisappear")
            }
        }
    }

    private var eventLog: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent events")
                .font(.headline)

            if logger.events.isEmpty {
                Text("Lifecycle events will appear here.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(logger.events.suffix(8).reversed()) { event in
                    Text("\(event.occurredAt.formatted(date: .omitted, time: .standard))  \(event.message)")
                        .font(.caption.monospaced())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }
}
