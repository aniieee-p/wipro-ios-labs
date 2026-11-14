import Foundation

public struct AuditChecklist: Equatable, Sendable {
    public let itemIDs: [String]
    public private(set) var completedItemIDs: Set<String>

    public init(itemIDs: [String], completedItemIDs: Set<String> = []) {
        self.itemIDs = itemIDs
        self.completedItemIDs = completedItemIDs.intersection(itemIDs)
    }

    public mutating func setCompleted(_ isCompleted: Bool, for itemID: String) {
        guard itemIDs.contains(itemID) else {
            return
        }

        if isCompleted {
            completedItemIDs.insert(itemID)
        } else {
            completedItemIDs.remove(itemID)
        }
    }

    public func isCompleted(_ itemID: String) -> Bool {
        completedItemIDs.contains(itemID)
    }

    public var completionFraction: Double {
        guard !itemIDs.isEmpty else { return 0 }
        return Double(completedItemIDs.count) / Double(itemIDs.count)
    }
}
