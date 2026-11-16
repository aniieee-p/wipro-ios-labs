
import Foundation

public enum DashboardState: Equatable {
    case idle
    case loading
    case success(DashboardData)
    case failure(String)
}

@MainActor
public final class DashboardViewModel {
    public private(set) var state: DashboardState = .idle

    private let service: DashboardService
    private var loadTask: Task<Void, Never>?

    public init(service: DashboardService = DashboardService()) {
        self.service = service
    }

    public func load(failingSource: DashboardSource? = nil) {
        loadTask?.cancel()
        state = .loading

        let service = self.service

        loadTask = Task {
            do {
                let dashboard = try await service.loadDashboard(
                    failingSource: failingSource
                )

                guard !Task.isCancelled else {
                    state = .idle
                    return
                }

                state = .success(dashboard)
            } catch is CancellationError {
                state = .idle
            } catch {
                guard !Task.isCancelled else {
                    state = .idle
                    return
                }

                state = .failure(error.localizedDescription)
            }
        }
    }

    public func cancel() {
        loadTask?.cancel()
        loadTask = nil
        state = .idle
    }
}
