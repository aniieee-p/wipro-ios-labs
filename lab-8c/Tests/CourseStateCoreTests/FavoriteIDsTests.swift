import XCTest
@testable import CourseStateCore

final class FavoriteIDsTests: XCTestCase {
    func testAddingAndRemovingFavoriteUpdatesMembership() {
        var favorites = FavoriteIDs()

        favorites.setFavorite(true, for: "swift")
        XCTAssertTrue(favorites.contains("swift"))

        favorites.setFavorite(false, for: "swift")
        XCTAssertFalse(favorites.contains("swift"))
    }

    func testFavoritesAreIdentifiedByCourseID() {
        var favorites = FavoriteIDs(ids: ["swift"])

        favorites.setFavorite(true, for: "uikit")

        XCTAssertEqual(favorites.all, ["swift", "uikit"])
    }
}
