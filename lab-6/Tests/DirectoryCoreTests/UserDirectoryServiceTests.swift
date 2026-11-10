import Foundation
import XCTest
@testable import DirectoryCore

final class UserDirectoryServiceTests: XCTestCase {
    func testDecodesUserAndNestedAddressAndCompany() async throws {
        let service = UserDirectoryService(transport: StubTransport(data: Self.userJSON, statusCode: 200))

        let users = try await service.fetchUsers()

        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users[0].name, "Ada Lovelace")
        XCTAssertEqual(users[0].address.city, "London")
        XCTAssertEqual(users[0].company.name, "Analytical Engines")
    }

    func testRejectsInvalidEndpoint() async {
        let service = UserDirectoryService(endpoint: "not a URL", transport: StubTransport(data: Data(), statusCode: 200))

        do {
            _ = try await service.fetchUsers()
            XCTFail("Expected invalid URL error.")
        } catch {
            XCTAssertEqual(error as? DirectoryError, .invalidURL)
        }
    }

    func testRejectsNonSuccessHTTPStatus() async {
        let service = UserDirectoryService(transport: StubTransport(data: Self.userJSON, statusCode: 503))

        do {
            _ = try await service.fetchUsers()
            XCTFail("Expected HTTP status error.")
        } catch {
            XCTAssertEqual(error as? DirectoryError, .httpStatus(503))
        }
    }

    func testReportsMalformedJSON() async {
        let service = UserDirectoryService(transport: StubTransport(data: Data("not json".utf8), statusCode: 200))

        do {
            _ = try await service.fetchUsers()
            XCTFail("Expected decoding error.")
        } catch {
            XCTAssertEqual(error as? DirectoryError, .decodingFailed)
        }
    }

    func testReturnsAnEmptyListForEmptyResponse() async throws {
        let service = UserDirectoryService(transport: StubTransport(data: Data("[]".utf8), statusCode: 200))

        let users = try await service.fetchUsers()

        XCTAssertTrue(users.isEmpty)
    }

    func testWrapsTransportFailure() async {
        let service = UserDirectoryService(transport: StubTransport(error: StubError.offline))

        do {
            _ = try await service.fetchUsers()
            XCTFail("Expected network error.")
        } catch {
            guard case .networkFailure = error as? DirectoryError else {
                return XCTFail("Expected a network failure.")
            }
        }
    }

    private static let userJSON = Data(
        """
        [{
          "id": 1,
          "name": "Ada Lovelace",
          "username": "ada",
          "email": "ada@example.com",
          "phone": "555-0100",
          "website": "example.com",
          "address": {
            "street": "Analytical Way",
            "suite": "1",
            "city": "London",
            "zipcode": "N1"
          },
          "company": { "name": "Analytical Engines" }
        }]
        """.utf8
    )
}

private struct StubTransport: DirectoryTransport {
    let data: Data
    let statusCode: Int
    let error: StubError?

    init(data: Data = Data(), statusCode: Int = 200, error: StubError? = nil) {
        self.data = data
        self.statusCode = statusCode
        self.error = error
    }

    func data(from url: URL) async throws -> (Data, Int) {
        if let error {
            throw error
        }
        return (data, statusCode)
    }
}

private enum StubError: Error {
    case offline
}
