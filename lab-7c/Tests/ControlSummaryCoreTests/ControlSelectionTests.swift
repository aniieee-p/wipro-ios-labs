import XCTest
@testable import ControlSummaryCore

final class ControlSelectionTests: XCTestCase {
    func testSummaryContainsEverySelectedControlValue() {
        let reminder = Date(timeIntervalSince1970: 0)
        let selection = ControlSelection(
            name: "  Anish  ",
            notificationsEnabled: true,
            studyMode: "Focused",
            weeklyGoal: 8,
            reminderDate: reminder
        )

        XCTAssertTrue(selection.summary.contains("Name: Anish"))
        XCTAssertTrue(selection.summary.contains("Notifications: On"))
        XCTAssertTrue(selection.summary.contains("Study mode: Focused"))
        XCTAssertTrue(selection.summary.contains("Weekly goal: 8 hours"))
        XCTAssertTrue(selection.summary.contains("Reminder:"))
    }

    func testEmptyNameHasReadableFallbackAndSwitchIsReflected() {
        let selection = ControlSelection(
            name: " ",
            notificationsEnabled: false,
            studyMode: "Balanced",
            weeklyGoal: 1,
            reminderDate: Date(timeIntervalSince1970: 0)
        )

        XCTAssertTrue(selection.summary.contains("Name: Not provided"))
        XCTAssertTrue(selection.summary.contains("Notifications: Off"))
    }
}
