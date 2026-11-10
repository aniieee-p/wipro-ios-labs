#if canImport(Combine)
import Combine
#endif
import Foundation

@MainActor
public final class DashboardViewModel {
    public enum State: Equatable {
        case idle
        case loading
        case success(DashboardData)
        case failure(String)
        case cancelled
    }

    #if canImport(Combine)
    @Published public private(set) var state: State = .idle
    #else
    public private(set) var state: State = .idle
    #endif

    private let service: DashboardService
    private var loadTask: Task<Void, Never>?

    public init(service: DashboardService = DashboardService()) {
        self.service = service
    }

    public func load(failingSource: DashboardSource? = nil) {
        guard loadTask == nil else { return }
        state = .loading
        loadTask = Task { [weak self] in
            guard let self else { return }
            defer { loadTask = nil }
            do {
                state = .success(try await service.loadDashboard(failingSource: failingSource))
            } catch is CancellationError {
                state = .cancelled
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }

    public func cancel() {
        loadTask?.cancel()
    }
}

#if canImport(Combine)
extension DashboardViewModel: ObservableObject {}
#endif
