import XCTest
@testable import LifecycleCore

final class EventLogStoreTests: XCTestCase {
    func testRecordAppendsEventsInOrder() {
        var store = EventLogStore()
        let firstDate = Date(timeIntervalSince1970: 1_000)
        let secondDate = Date(timeIntervalSince1970: 2_000)

        let first = store.record("App started", at: firstDate)
        let second = store.record("Home appeared", at: secondDate)

        XCTAssertEqual(store.events, [first, second])
        XCTAssertEqual(first.occurredAt, firstDate)
        XCTAssertEqual(second.message, "Home appeared")
    }
}
