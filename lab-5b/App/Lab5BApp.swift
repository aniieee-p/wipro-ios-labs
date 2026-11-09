import CourseLoadingCore
import SwiftUI

@main
struct Lab5BApp: App {
    var body: some Scene {
        WindowGroup {
            CourseCatalogView()
        }
    }
}

@MainActor
private struct CourseCatalogView: View {
    @StateObject private var model = CourseLoadingModel()
    @State private var selectedScenario: CourseFetchScenario = .success

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Async Course Catalog")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                Text("Select a response to explore success, empty, and failure states. You can cancel any request while it is loading.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Picker("Response", selection: $selectedScenario) {
                    Text("Success").tag(CourseFetchScenario.success)
                    Text("Empty").tag(CourseFetchScenario.empty)
                    Text("Failure").tag(CourseFetchScenario.failure)
                }
                .pickerStyle(.segmented)
                .disabled(isLoading)

                stateContent
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding()
            .navigationTitle("Lab 5B")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private var stateContent: some View {
        switch model.state {
        case .idle:
            Button("Load courses") {
                model.load(scenario: selectedScenario)
            }
            .buttonStyle(.borderedProminent)
        case .loading:
            VStack(spacing: 16) {
                ProgressView("Fetching courses…")
                Button("Cancel request", role: .destructive) {
                    model.cancel()
                }
                .buttonStyle(.bordered)
            }
        case .success(let courses):
            VStack(alignment: .leading, spacing: 12) {
                Label("Loaded \(courses.count) courses", systemImage: "checkmark.circle.fill")
                    .font(.headline)
                    .foregroundStyle(.green)

                ForEach(courses) { course in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(course.title).font(.body.bold())
                        Text("Instructor: \(course.instructor)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
                }

                Button("Load again") {
                    model.load(scenario: selectedScenario)
                }
                .buttonStyle(.borderedProminent)
            }
        case .empty:
            VStack(spacing: 12) {
                Image(systemName: "tray")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                Text("No courses were found.")
                Button("Try again") {
                    model.load(scenario: selectedScenario)
                }
                .buttonStyle(.borderedProminent)
            }
        case .failure(let message):
            VStack(spacing: 12) {
                Label("Could not load courses", systemImage: "exclamationmark.triangle.fill")
                    .font(.headline)
                    .foregroundStyle(.red)
                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                Button("Retry") {
                    model.load(scenario: selectedScenario)
                }
                .buttonStyle(.borderedProminent)
            }
        case .cancelled:
            VStack(spacing: 12) {
                Label("Request cancelled", systemImage: "xmark.circle")
                    .font(.headline)
                Button("Load again") {
                    model.load(scenario: selectedScenario)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    private var isLoading: Bool {
        if case .loading = model.state {
            return true
        }
        return false
    }
}
