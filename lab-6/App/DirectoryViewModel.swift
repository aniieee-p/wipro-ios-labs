import Combine
import DirectoryCore
import Foundation

@MainActor
final class DirectoryViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case success([DirectoryUser])
        case empty
        case failure(String)
        case cancelled
    }

    @Published private(set) var state: State = .idle
    @Published var searchText = ""

    private let service: UserDirectoryService
    private var loadTask: Task<Void, Never>?

    init(service: UserDirectoryService) {
        self.service = service
    }

    var visibleUsers: [DirectoryUser] {
        guard case .success(let users) = state else { return [] }
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return users }
        return users.filter {
            $0.name.localizedCaseInsensitiveContains(query)
                || $0.email.localizedCaseInsensitiveContains(query)
                || $0.company.name.localizedCaseInsensitiveContains(query)
        }
    }

    func load() {
        guard loadTask == nil else { return }
        state = .loading
        loadTask = Task { [weak self] in
            guard let self else { return }
            defer { loadTask = nil }

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

    func cancel() {
        loadTask?.cancel()
    }
}
