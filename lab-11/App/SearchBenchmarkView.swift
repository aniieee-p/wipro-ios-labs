import CourseSearchCore
import SwiftUI

struct SearchBenchmarkView: View {
    @State private var report: SearchBenchmarkReport?
    @State private var isRunning = false
    @State private var failureMessage: String?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Repeated Search Work", systemImage: "speedometer")
                            .font(.title2.bold())
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Compare repeated title normalization with a prebuilt search index using the same deterministic catalog and queries.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        Button {
                            runBenchmark()
                        } label: {
                            HStack {
                                Spacer()
                                if isRunning {
                                    ProgressView()
                                        .padding(.trailing, 4)
                                }
                                Text(isRunning ? "Running..." : "Run repeatable workload")
                                Spacer()
                            }
                            .frame(minHeight: 44)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(isRunning)
                        .accessibilityIdentifier("benchmark.run")
                    }
                    .padding(.vertical, 8)
                }

                if let failureMessage {
                    Section("Error") {
                        Text(failureMessage)
                            .foregroundStyle(.red)
                    }
                }

                if let report {
                    Section("Baseline: normalize on every query") {
                        metric("Elapsed", value: formatted(report.baseline.elapsedMilliseconds))
                        metric("Title normalizations", value: "\(report.baseline.normalizedTitleCount)")
                        metric("Total matches", value: "\(report.baseline.totalMatches)")
                    }

                    Section("Improved: build index once") {
                        metric("Elapsed (including index build)", value: formatted(report.indexed.elapsedMilliseconds))
                        metric("Title normalizations", value: "\(report.indexed.normalizedTitleCount)")
                        metric("Total matches", value: "\(report.indexed.totalMatches)")
                    }

                    Section("Verification and conditions") {
                        Label(
                            report.resultsMatch ? "Results match" : "Results differ",
                            systemImage: report.resultsMatch ? "checkmark.circle" : "xmark.circle"
                        )
                        .foregroundStyle(report.resultsMatch ? .green : .red)
                        metric("Catalog", value: "\(report.courseCount) deterministic courses")
                        metric("Queries", value: "\(report.queries.count) fixed searches")
                        Text("Elapsed times are observations from this run, not guaranteed performance gains. Repeat in Instruments under matching build/device conditions.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                } else {
                    Section("Workload") {
                        Text("The catalog and eight queries are generated deterministically. Run the workload several times on the same simulator or device for profiling.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Lab 11 Profiling")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func metric(_ title: String, value: String) -> some View {
        LabeledContent(title, value: value)
    }

    private func formatted(_ milliseconds: Double) -> String {
        String(format: "%.2f ms", milliseconds)
    }

    private func runBenchmark() {
        guard !isRunning else { return }
        failureMessage = nil
        isRunning = true

        Task { @MainActor in
            defer { isRunning = false }
            let result = await Task.detached(priority: .userInitiated) {
                CourseSearchBenchmark.run()
            }.value
            guard result.resultsMatch else {
                failureMessage = "The baseline and indexed results differ."
                return
            }
            report = result
        }
    }
}

#Preview {
    SearchBenchmarkView()
}
