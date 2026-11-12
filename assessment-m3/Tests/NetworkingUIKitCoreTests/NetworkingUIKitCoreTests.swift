import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import XCTest
@testable import NetworkingUIKitCore

@MainActor
final class NetworkingUIKitCoreTests: XCTestCase {
    func testValidProfilePasses() {
        let result = ProfileFormValidator.validate(
            ProfileFormInput(name: " Ada ", email: "ada@example.com", course: " Swift ")
        )

        XCTAssertTrue(result.isEmpty)
    }

    func testMissingRequiredFieldsAreReportedTogether() {
        let result = ProfileFormValidator.validate(ProfileFormInput(name: " ", email: "", course: ""))

        XCTAssertEqual(Set(result.fields.keys), Set([.name, .email, .course]))
    }

    func testMalformedEmailIsReported() {
        let result = ProfileFormValidator.validate(
            ProfileFormInput(name: "Ada", email: "ada@", course: "Swift")
        )

        XCTAssertEqual(result.fields[.email], "Enter a valid email address.")
    }

    func testDecodesJSONIntoNestedCodableModels() async throws {
        let service = UserDirectoryService(transport: StubTransport(data: Self.userJSON))

        let users = try await service.fetchUsers()

        XCTAssertEqual(users.first?.name, "Ada Lovelace")
        XCTAssertEqual(users.first?.address.city, "London")
        XCTAssertEqual(users.first?.company.name, "Analytical Engines")
    }

    func testNonSuccessStatusBecomesHTTPError() async {
        let service = UserDirectoryService(
            transport: StubTransport(data: Self.userJSON, statusCode: 503)
        )

        do {
            _ = try await service.fetchUsers()
            XCTFail("Expected HTTP status error.")
        } catch {
            XCTAssertEqual(error as? DirectoryError, .httpStatus(503))
        }
    }

    func testMalformedResponseBecomesDecodingError() async {
        let service = UserDirectoryService(transport: StubTransport(data: Data("nope".utf8)))

        do {
            _ = try await service.fetchUsers()
            XCTFail("Expected decoding error.")
        } catch {
            XCTAssertEqual(error as? DirectoryError, .decodingFailed)
        }
    }

    func testEmptyResponseProducesEmptyState() async throws {
        let model = DirectoryViewModel(
            service: UserDirectoryService(transport: StubTransport(data: Data("[]".utf8)))
        )

        model.load()
        try await waitForTerminalState(model)

        let state = model.state
        XCTAssertEqual(state, .empty)
    }

    func testTransportFailureProducesFailureState() async throws {
        let model = DirectoryViewModel(
            service: UserDirectoryService(transport: StubTransport(error: .offline))
        )

        model.load()
        try await waitForTerminalState(model)

        let state = model.state
        guard case .failure(let message) = state else {
            return XCTFail("Expected a visible failure state.")
        }
        XCTAssertTrue(message.contains("offline"))
    }

    private func waitForTerminalState(_ model: DirectoryViewModel) async throws {
        for _ in 0..<100 {
            switch model.state {
            case .idle, .loading:
                try await Task.sleep(for: .milliseconds(10))
            case .success, .empty, .failure, .cancelled:
                return
            }
        }
        XCTFail("Directory did not reach a terminal state.")
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

    func data(for request: URLRequest) async throws -> (Data, Int) {
        if let error {
            throw error
        }
        return (data, statusCode)
    }
}

private enum StubError: Error, LocalizedError, Sendable {
    case offline

    var errorDescription: String? {
        "offline"
    }
}
