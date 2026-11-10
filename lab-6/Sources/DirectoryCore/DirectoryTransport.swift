import Foundation

public protocol DirectoryTransport: Sendable {
    func data(from url: URL) async throws -> (Data, Int)
}

public enum DirectoryError: Error, Equatable, LocalizedError, Sendable {
    case invalidURL
    case httpStatus(Int)
    case decodingFailed
    case networkFailure(String)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The directory URL is invalid."
        case .httpStatus(let code):
            return "The server returned HTTP \(code)."
        case .decodingFailed:
            return "The server response could not be read as a user directory."
        case .networkFailure(let message):
            return "Network request failed: \(message)"
        }
    }
}

public struct UserDirectoryService: Sendable {
    public static let defaultEndpoint = "https://jsonplaceholder.typicode.com/users"

    private let endpoint: String
    private let transport: any DirectoryTransport

    public init(
        endpoint: String = UserDirectoryService.defaultEndpoint,
        transport: any DirectoryTransport
    ) {
        self.endpoint = endpoint
        self.transport = transport
    }

    public func fetchUsers() async throws -> [DirectoryUser] {
        guard
            var components = URLComponents(string: endpoint),
            components.scheme == "https",
            components.host != nil
        else {
            throw DirectoryError.invalidURL
        }
        components.queryItems = nil

        guard let requestURL = components.url else {
            throw DirectoryError.invalidURL
        }

        let data: Data
        let statusCode: Int
        do {
            (data, statusCode) = try await transport.data(from: requestURL)
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
