import Foundation

// Tracks which book IDs the user has marked as favourites.
// Stored as @State on the list view so toggles on the detail view stay in sync.
public struct FavouritesStore: Equatable {
    public var favouriteIDs: Set<String>

    public init(favouriteIDs: Set<String> = []) {
        self.favouriteIDs = favouriteIDs
    }

    public func isFavourite(_ bookID: String) -> Bool {
        return favouriteIDs.contains(bookID)
    }

    public mutating func setFavourite(_ favourite: Bool, for bookID: String) {
        if favourite {
            favouriteIDs.insert(bookID)
        } else {
            favouriteIDs.remove(bookID)
        }
    }

    public mutating func toggle(_ bookID: String) -> Bool {
        let isCurrentlyFavourite = isFavourite(bookID)
        setFavourite(!isCurrentlyFavourite, for: bookID)
        return !isCurrentlyFavourite
    }

    public var count: Int {
        return favouriteIDs.count
    }
}
