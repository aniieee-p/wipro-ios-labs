import Foundation

public struct FavoriteIDs: Equatable, Sendable {
    var ids: Set<String>

    public init(ids: Set<String> = []) {
        self.ids = ids
    }

    public func contains(_ id: String) -> Bool {
        return ids.contains(id)
    }

    public mutating func setFavorite(_ isFavorite: Bool, for id: String) {
        if isFavorite {
            ids.insert(id)
        } else {
            ids.remove(id)
        }
    }

    public var all: Set<String> {
        return ids
    }
}
