
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// Protocol so tests can inject a stub instead of hitting the real network
public protocol DirectoryTransport {
    func data(from url: URL) async throws -> (Data, Int)
}

// Default transport using URLSession
public struct URLSessionDirectoryTransport: DirectoryTransport {
    public init() {}

    public func data(from url: URL) async throws -> (Data, Int) {
        let (data, response) = try await URLSession.shared.data(from: url)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

        return (data, statusCode)
    }
}

public enum DirectoryError: Error, Equatable {
    case invalidURL
    case httpStatus(Int)
    case decodingFailed
    case networkFailure(String)
}

public struct UserDirectoryService {
    public static let endpoint =
        "https://jsonplaceholder.typicode.com/users"

    private let endpointString: String
    private let transport: any DirectoryTransport

    public init(
        endpoint: String = UserDirectoryService.endpoint,
        transport: any DirectoryTransport = URLSessionDirectoryTransport()
    ) {
        self.endpointString = endpoint
        self.transport = transport
    }

    public func fetchUsers() async throws -> [DirectoryUser] {
        guard let url = URL(string: endpointString) else {
            throw DirectoryError.invalidURL
        }

        let data: Data
        let statusCode: Int

        do {
            (data, statusCode) = try await transport.data(from: url)
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw DirectoryError.networkFailure(error.localizedDescription)
        }

        guard (200..<300).contains(statusCode) else {
            throw DirectoryError.httpStatus(statusCode)
        }

        do {
            return try JSONDecoder().decode([DirectoryUser].self, from: data)
        } catch {
            throw DirectoryError.decodingFailed
        }
    }
}
