import XCTest
@testable import ConfigurationAuditCore

final class AuditChecklistTests: XCTestCase {
    func testCompletionProgressTracksCheckedItems() {
        var checklist = AuditChecklist(itemIDs: ["target", "identity", "version", "signing"])

        checklist.setCompleted(true, for: "target")
        checklist.setCompleted(true, for: "version")

        XCTAssertEqual(checklist.completionFraction, 0.5)
        XCTAssertTrue(checklist.isCompleted("target"))
        XCTAssertFalse(checklist.isCompleted("identity"))
    }

    func testUncheckingAnItemRemovesItFromProgress() {
        var checklist = AuditChecklist(itemIDs: ["target", "version"], completedItemIDs: ["target", "version"])

        checklist.setCompleted(false, for: "version")

        XCTAssertEqual(checklist.completionFraction, 0.5)
        XCTAssertFalse(checklist.isCompleted("version"))
    }

    func testUnknownItemsAreIgnored() {
        var checklist = AuditChecklist(itemIDs: ["target"])

        checklist.setCompleted(true, for: "unknown")

        XCTAssertTrue(checklist.completedItemIDs.isEmpty)
    }

    func testEmptyChecklistHasZeroProgress() {
        XCTAssertEqual(AuditChecklist(itemIDs: []).completionFraction, 0)
    }
}
