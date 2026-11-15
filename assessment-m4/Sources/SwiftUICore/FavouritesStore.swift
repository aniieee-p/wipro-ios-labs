import Foundation

// MARK: - FavouritesStore (R2 state logic)

/// Tracks which book IDs the user has marked as favourites.
///
/// `FavouritesStore` is a plain value type so it can be held in `@State`
/// on the list view and passed down as `@Binding` to the detail view.
/// Any toggle on the detail screen mutates the same store in the parent,
/// keeping both views in sync automatically.
public struct FavouritesStore: Equatable, Sendable {
    public private(set) var favouriteIDs: Set<String>

    public init(favouriteIDs: Set<String> = []) {
        self.favouriteIDs = favouriteIDs
    }

    /// Returns `true` when the given book ID is in the favourites set.
    public func isFavourite(_ bookID: String) -> Bool {
        favouriteIDs.contains(bookID)
    }

    /// Adds the book ID when `favourite` is `true`; removes it otherwise.
    public mutating func setFavourite(_ favourite: Bool, for bookID: String) {
        if favourite {
            favouriteIDs.insert(bookID)
        } else {
            favouriteIDs.remove(bookID)
        }
    }

    /// Toggles the book's favourite state and returns the new value.
    @discardableResult
    public mutating func toggle(_ bookID: String) -> Bool {
        let next = !isFavourite(bookID)
        setFavourite(next, for: bookID)
        return next
    }

    /// How many books are currently favourited.
    public var count: Int { favouriteIDs.count }
}
