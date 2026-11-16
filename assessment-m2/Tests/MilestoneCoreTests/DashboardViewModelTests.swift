import XCTest
@testable import MilestoneCore

@MainActor
final class DashboardViewModelTests: XCTestCase {
    func testLoadsAndCombinesIndependentSources() async throws {
        let viewModel = DashboardViewModel(service: DashboardService(delaySeconds: 0.02))

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
        let viewModel = DashboardViewModel(service: DashboardService(delaySeconds: 0.01))

        viewModel.load(failingSource: .courses)
        try await waitForTerminalState(viewModel)

        guard case .failure = viewModel.state else {
            return XCTFail("Expected a visible error state.")
        }
    }

    func testCancellationSetsStateBackToIdle() async throws {
        let viewModel = DashboardViewModel(service: DashboardService(delaySeconds: 2.0))

        viewModel.load()
        viewModel.cancel()
        try await waitForTerminalState(viewModel)

        XCTAssertEqual(viewModel.state, .idle)
    }

    private func waitForTerminalState(_ viewModel: DashboardViewModel) async throws {
        for _ in 0..<200 {
            if case .loading = viewModel.state {
                try await Task.sleep(nanoseconds: 10_000_000)
            } else {
                return
            }
        }
        XCTFail("View model did not reach a terminal state in time.")
    }
}
