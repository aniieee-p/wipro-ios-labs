
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol DirectoryTransport: Sendable {
    func data(for request: URLRequest) async throws -> (Data, Int)
}

public struct URLSessionDirectoryTransport: DirectoryTransport {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func data(for request: URLRequest) async throws -> (Data, Int) {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw DirectoryError.invalidResponse
        }

        return (data, httpResponse.statusCode)
    }
}

public enum DirectoryError: Error, Equatable, Sendable {
    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decodingFailed
    case networkFailure(String)

    public var message: String {
        switch self {
        case .invalidURL:
            return "The directory URL is invalid."
        case .invalidResponse:
            return "The server response was not a valid HTTP response."
        case .httpStatus(let code):
            return "The server returned HTTP \(code)."
        case .decodingFailed:
            return "The server response could not be decoded."
        case .networkFailure(let message):
            return "Network request failed: \(message)"
        }
    }
}

public struct UserDirectoryService: Sendable {
    public static let endpoint = "https://jsonplaceholder.typicode.com/users"

    private let endpointString: String
    private let transport: any DirectoryTransport

    public init(
        endpoint: String = UserDirectoryService.endpoint,
        transport: any DirectoryTransport
    ) {
        self.endpointString = endpoint
        self.transport = transport
    }

    public func fetchUsers() async throws -> [DirectoryUser] {
        guard
            let components = URLComponents(string: endpointString),
            components.scheme == "https",
            components.host != nil,
            let url = components.url
        else {
            throw DirectoryError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let data: Data
        let statusCode: Int

        do {
            (data, statusCode) = try await transport.data(for: request)
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
