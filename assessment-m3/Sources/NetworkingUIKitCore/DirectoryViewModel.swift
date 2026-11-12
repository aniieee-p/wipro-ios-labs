import Foundation

#if canImport(Combine)
import Combine
#endif

@MainActor
public final class DirectoryViewModel {
    public enum State: Equatable, Sendable {
        case idle
        case loading
        case success([DirectoryUser])
        case empty
        case failure(String)
        case cancelled
    }

    #if canImport(Combine)
    @Published public private(set) var state: State = .idle
    #else
    public private(set) var state: State = .idle
    #endif

    private let service: UserDirectoryService
    private var requestTask: Task<Void, Never>?

    public init(service: UserDirectoryService) {
        self.service = service
    }

    public func load() {
        guard requestTask == nil else { return }
        state = .loading
        requestTask = Task { [weak self] in
            guard let self else { return }
            defer { requestTask = nil }
            do {
                let users = try await service.fetchUsers()
                try Task.checkCancellation()
                state = users.isEmpty ? .empty : .success(users)
            } catch is CancellationError {
                state = .cancelled
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }

    public func cancel() {
        requestTask?.cancel()
    }
}

#if canImport(Combine)
extension DirectoryViewModel: ObservableObject {}
#endif
