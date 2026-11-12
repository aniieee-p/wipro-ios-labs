import Combine
import Foundation

@MainActor
public final class CourseLibrary: ObservableObject {
    public let courses: [Course]
    @Published public private(set) var favorites: FavoriteIDs

    private let defaults: UserDefaults
    private let favoritesKey = "lab8c.favoriteCourseIDs"

    public init(
        courses: [Course] = Course.samples,
        defaults: UserDefaults = .standard
    ) {
        self.courses = courses
        self.defaults = defaults
        let savedIDs = Set(defaults.stringArray(forKey: favoritesKey) ?? [])
        let validCourseIDs = Set(courses.map(\.id))
        favorites = FavoriteIDs(ids: savedIDs.intersection(validCourseIDs))
    }

    public func isFavorite(_ courseID: String) -> Bool {
        favorites.contains(courseID)
    }

    public func setFavorite(_ isFavorite: Bool, for courseID: String) {
        guard courses.contains(where: { $0.id == courseID }) else {
            return
        }

        var updatedFavorites = favorites
        updatedFavorites.setFavorite(isFavorite, for: courseID)
        guard updatedFavorites != favorites else {
            return
        }

        favorites = updatedFavorites
        defaults.set(favorites.all.sorted(), forKey: favoritesKey)
    }
}
