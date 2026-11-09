import Combine
import CourseLoadingCore
import Foundation

@MainActor
final class CourseLoadingModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case success([Course])
        case empty
        case failure(String)
        case cancelled
    }

    @Published private(set) var state: State = .idle

    private let service = CourseCatalogService()
    private var loadTask: Task<Void, Never>?

    func load(scenario: CourseFetchScenario) {
        guard loadTask == nil else { return }

        state = .loading
        loadTask = Task { [weak self] in
            guard let self else { return }
            defer { self.loadTask = nil }

            do {
                let courses = try await service.fetchCourses(for: scenario)
                state = courses.isEmpty ? .empty : .success(courses)
            } catch is CancellationError {
                state = .cancelled
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }

    func cancel() {
        loadTask?.cancel()
    }
}
