import DirectoryCore
import Foundation

struct URLSessionDirectoryTransport: DirectoryTransport {
    func data(from url: URL) async throws -> (Data, Int) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw DirectoryError.invalidURL
        }
        return (data, response.statusCode)
    }
}
