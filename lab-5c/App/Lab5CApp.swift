import CourseDetailsCore
import SwiftUI

@main
struct Lab5CApp: App {
    var body: some Scene {
        WindowGroup {
            CourseComparisonView()
        }
    }
}

@MainActor
private struct CourseComparisonView: View {
    @StateObject private var model = CourseComparisonModel()
    @State private var failureChoice = "None"

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Task Group Timing")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                Text(model.status)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Picker("Simulated failure", selection: $failureChoice) {
                    Text("No failures").tag("None")
                    Text("Fail course B").tag("B")
                }
                .pickerStyle(.segmented)
                .disabled(model.isRunning)

                if model.isRunning {
                    ProgressView("Comparing four requests…")
                    Button("Cancel comparison", role: .destructive) {
                        model.cancel()
                    }
                    .buttonStyle(.bordered)
                } else {
                    Button("Compare sequential and concurrent") {
                        model.compare(failingID: failureChoice == "None" ? nil : failureChoice)
                    }
                    .buttonStyle(.borderedProminent)
                }

                if let comparison = model.comparison {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            resultSection(title: "Sequential", result: comparison.sequential)
                            resultSection(title: "Task group", result: comparison.concurrent)
                        }
                    }
                } else {
                    Spacer()
                    Text("Each request simulates 0.7 seconds of work.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Lab 5C")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func resultSection(title: String, result: TimedCourseDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(title) · \(result.elapsedSeconds, specifier: "%.2f") seconds")
                .font(.headline)

            ForEach(result.outcomes) { outcome in
                switch outcome {
                case .success(let course):
                    Label("\(course.title) — \(course.instructor)", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                case .failure(let id, let message):
                    Label("Course \(id) failed: \(message)", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }
}
