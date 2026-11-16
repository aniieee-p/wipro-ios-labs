
import Foundation

#if canImport(Combine)
import Combine
#else
public protocol ObservableObject: AnyObject {}

@propertyWrapper
public struct Published<Value> {
    public var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
#endif

public protocol CourseService {
    func fetchCourses() throws -> [Course]
}

public enum CourseLoadingState: Equatable, Sendable {
    case idle
    case loaded([Course])
    case empty
    case failed(String)
}

public final class CourseListViewModel: ObservableObject {
    @Published public private(set) var state: CourseLoadingState = .idle

    private let service: any CourseService

    public init(service: any CourseService) {
        self.service = service
    }

    public func loadCourses() {
        do {
            let courses = try service.fetchCourses()

            if courses.isEmpty {
                state = .empty
            } else {
                state = .loaded(courses)
            }
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
