import SwiftUI

@main
struct Lab5DApp: App {
    var body: some Scene {
        WindowGroup {
            CounterDemoView()
        }
    }
}

@MainActor
private struct CounterDemoView: View {
    @StateObject private var model = CounterDemoModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Concurrency Safety")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                Text("Many tasks increment each counter at the same time. Compare the unsafe result with the actor-protected result.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button("Run counter experiment") {
                    model.runExperiment()
                }
                .buttonStyle(.borderedProminent)
                .disabled(model.isRunning)

                if model.isRunning {
                    ProgressView()
                }

                Text(model.message)
                    .multilineTextAlignment(.center)

                if let result = model.result {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Expected: \(result.expectedCount)")
                            .font(.headline)
                        Label("Before — unsafe: \(result.unsafeCount)", systemImage: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                        Label("After — actor: \(result.safeCount)", systemImage: "checkmark.shield.fill")
                            .foregroundStyle(.green)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Lab 5D")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
