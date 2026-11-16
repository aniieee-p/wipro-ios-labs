
import Foundation

#if canImport(Combine)
import Combine
#else
public protocol ObservableObject: AnyObject {}

@propertyWrapper
public struct Published<Value> {
    public var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
#endif

@MainActor
public final class DirectoryViewModel: ObservableObject {
    public enum State: Equatable {
        case idle
        case loading
        case success([DirectoryUser])
        case empty
        case failure(String)
        case cancelled
    }

    @Published public private(set) var state: State = .idle

    private let service: UserDirectoryService
    private var requestTask: Task<Void, Never>?

    public init(service: UserDirectoryService) {
        self.service = service
    }

    public func load() {
        if requestTask != nil {
            return
        }

        state = .loading
        let service = self.service

        requestTask = Task { [weak self, service] in
            do {
                let users = try await service.fetchUsers()
                try Task.checkCancellation()

                guard let self else {
                    return
                }

                self.state = users.isEmpty ? .empty : .success(users)
                self.requestTask = nil
            } catch is CancellationError {
                guard let self else {
                    return
                }

                self.state = .cancelled
                self.requestTask = nil
            } catch {
                guard let self else {
                    return
                }

                self.state = .failure(error.localizedDescription)
                self.requestTask = nil
            }
        }
    }

    public func cancel() {
        requestTask?.cancel()
        requestTask = nil
    }
}
