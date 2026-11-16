import Foundation

public protocol CourseCatalogService {
    func fetchCourses() throws -> [Course]
}

public struct LocalCourseCatalogService: CourseCatalogService {
    private let courses: [Course]

    public init(courses: [Course] = Course.samples) {
        self.courses = courses
    }

    public func fetchCourses() throws -> [Course] {
        courses
    }
}
