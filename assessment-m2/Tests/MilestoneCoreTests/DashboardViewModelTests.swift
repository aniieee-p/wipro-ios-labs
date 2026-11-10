import XCTest
@testable import MilestoneCore

@MainActor
final class DashboardViewModelTests: XCTestCase {
    func testLoadsAndCombinesIndependentSources() async throws {
        let viewModel = DashboardViewModel(service: DashboardService(delay: .milliseconds(20)))

        viewModel.load()
        XCTAssertEqual(viewModel.state, .loading)
        try await waitForTerminalState(viewModel)

        guard case .success(let dashboard) = viewModel.state else {
            return XCTFail("Expected both sources to load successfully.")
        }
        XCTAssertEqual(dashboard.courses.count, 2)
        XCTAssertEqual(dashboard.announcements.count, 2)
    }

    func testServiceFailureProducesErrorState() async throws {
        let viewModel = DashboardViewModel(service: DashboardService(delay: .milliseconds(10)))

        viewModel.load(failingSource: .courses)
        try await waitForTerminalState(viewModel)

        guard case .failure(let message) = viewModel.state else {
            return XCTFail("Expected a visible error state.")
        }
        XCTAssertTrue(message.contains("courses"))
    }

    func testCancellationProducesCancelledState() async throws {
        let viewModel = DashboardViewModel(service: DashboardService(delay: .seconds(2)))

        viewModel.load()
        viewModel.cancel()
        try await waitForTerminalState(viewModel)

        XCTAssertEqual(viewModel.state, .cancelled)
    }

    private func waitForTerminalState(_ viewModel: DashboardViewModel) async throws {
        for _ in 0..<200 {
            switch viewModel.state {
            case .loading, .idle:
                try await Task.sleep(for: .milliseconds(10))
            case .success, .failure, .cancelled:
                return
            }
        }
        XCTFail("View model did not reach a terminal state in time.")
    }
}
