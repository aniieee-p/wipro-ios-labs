import Foundation

public protocol CourseService {
    func fetchCourses() throws -> [Course]
}

public enum CourseLoadingState: Equatable, Sendable {
    case idle
    case loaded([Course])
    case empty
    case failed(String)
}

#if canImport(Combine)
import Combine
#endif

public final class CourseListViewModel {
    #if canImport(Combine)
    @Published public private(set) var state: CourseLoadingState = .idle
    #else
    public private(set) var state: CourseLoadingState = .idle
    #endif

    private let service: any CourseService

    public init(service: any CourseService) {
        self.service = service
    }

    public func loadCourses() {
        do {
            let courses = try service.fetchCourses()
            state = courses.isEmpty ? .empty : .loaded(courses)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}

#if canImport(Combine)
extension CourseListViewModel: ObservableObject {}
#endif
