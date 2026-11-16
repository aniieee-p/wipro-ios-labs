
import Foundation

public enum PlannerError: Error, Equatable, Sendable {
    case courseNotFound
    case alreadyPlanned
    case scheduleConflict(withCourseID: String)
    case creditLimitExceeded(limit: Int)

    public var message: String {
        switch self {
        case .courseNotFound:
            "That course is no longer available."
        case .alreadyPlanned:
            "This course is already in your plan."
        case .scheduleConflict:
            "This course overlaps another planned class."
        case let .creditLimitExceeded(limit):
            "Your plan cannot exceed \(limit) credits."
        }
    }
}

public struct CoursePlannerModel: Equatable, Sendable {
    public let creditLimit: Int
    public private(set) var courses: [Course]
    public private(set) var plannedCourseIDs: Set<String>

    public init(
        courses: [Course] = [],
        plannedCourseIDs: Set<String> = [],
        creditLimit: Int = 18
    ) {
        self.creditLimit = creditLimit
        self.courses = courses
        self.plannedCourseIDs = plannedCourseIDs.intersection(
            Set(courses.map(\.id))
        )
    }

    public var plannedCourses: [Course] {
        courses
            .filter { plannedCourseIDs.contains($0.id) }
            .sorted {
                if $0.weekday != $1.weekday {
                    return $0.weekday < $1.weekday
                }

                if $0.startMinute != $1.startMinute {
                    return $0.startMinute < $1.startMinute
                }

                return $0.id < $1.id
            }
    }

    public var totalCredits: Int {
        plannedCourses.reduce(0) { $0 + $1.credits }
    }

    public var remainingCredits: Int {
        creditLimit - totalCredits
    }

    public mutating func replaceCatalog(with courses: [Course]) {
        self.courses = courses
        plannedCourseIDs.formIntersection(Set(courses.map(\.id)))
    }

    public mutating func addCourse(id: String) -> Result<Void, PlannerError> {
        guard let course = courses.first(where: { $0.id == id }) else {
            return .failure(.courseNotFound)
        }

        guard !plannedCourseIDs.contains(id) else {
            return .failure(.alreadyPlanned)
        }

        if let conflictingCourse = plannedCourses.first(
            where: { overlaps(course, $0) }
        ) {
            return .failure(
                .scheduleConflict(withCourseID: conflictingCourse.id)
            )
        }

        guard totalCredits + course.credits <= creditLimit else {
            return .failure(.creditLimitExceeded(limit: creditLimit))
        }

        plannedCourseIDs.insert(id)
        return .success(())
    }

    public mutating func removeCourse(id: String) -> Bool {
        plannedCourseIDs.remove(id) != nil
    }

    public func search(_ query: String) -> [Course] {
        let term = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !term.isEmpty else {
            return courses
        }

        return courses.filter {
            $0.title.localizedCaseInsensitiveContains(term)
                || $0.instructor.localizedCaseInsensitiveContains(term)
                || $0.category.localizedCaseInsensitiveContains(term)
        }
    }

    private func overlaps(_ first: Course, _ second: Course) -> Bool {
        first.weekday == second.weekday
            && first.startMinute < second.endMinute
            && second.startMinute < first.endMinute
    }
}
