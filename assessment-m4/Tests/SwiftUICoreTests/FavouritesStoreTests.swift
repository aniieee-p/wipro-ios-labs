import XCTest
@testable import SwiftUICore

final class FavouritesStoreTests: XCTestCase {

    func testNewStoreHasNoFavourites() {
        let store = FavouritesStore()
        XCTAssertEqual(store.count, 0)
        XCTAssertFalse(store.isFavourite("swift-prog"))
    }

    func testAddingFavouriteIncreasesCount() {
        var store = FavouritesStore()
        store.setFavourite(true, for: "swift-prog")
        XCTAssertTrue(store.isFavourite("swift-prog"))
        XCTAssertEqual(store.count, 1)
    }

    func testRemovingFavouriteDecreasesCount() {
        var store = FavouritesStore(favouriteIDs: ["swift-prog", "clean-code"])
        store.setFavourite(false, for: "swift-prog")
        XCTAssertFalse(store.isFavourite("swift-prog"))
        XCTAssertTrue(store.isFavourite("clean-code"))
        XCTAssertEqual(store.count, 1)
    }

    func testToggleSwitchesState() {
        var store = FavouritesStore()
        let first = store.toggle("sapiens")
        XCTAssertTrue(first)
        XCTAssertTrue(store.isFavourite("sapiens"))

        let second = store.toggle("sapiens")
        XCTAssertFalse(second)
        XCTAssertFalse(store.isFavourite("sapiens"))
    }

    func testTogglingMultipleBooksIsIndependent() {
        var store = FavouritesStore()
        store.toggle("atomic-habits")
        store.toggle("sapiens")
        store.toggle("atomic-habits")   // remove again

        XCTAssertFalse(store.isFavourite("atomic-habits"))
        XCTAssertTrue(store.isFavourite("sapiens"))
        XCTAssertEqual(store.count, 1)
    }

    func testInitWithPreloadedIDs() {
        let store = FavouritesStore(favouriteIDs: ["a", "b", "c"])
        XCTAssertEqual(store.count, 3)
        XCTAssertTrue(store.isFavourite("a"))
        XCTAssertFalse(store.isFavourite("z"))
    }
}
