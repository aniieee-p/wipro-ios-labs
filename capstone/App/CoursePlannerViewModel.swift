import Combine
import CoursePlannerCore
import Foundation

@MainActor
final class CoursePlannerViewModel: ObservableObject {
    enum CatalogState: Equatable {
        case idle
        case loaded
        case empty
        case failed(String)
    }

    @Published private(set) var planner = CoursePlannerModel()
    @Published private(set) var catalogState: CatalogState = .idle
    @Published var searchText = ""
    @Published private(set) var feedbackMessage: String?

    private let service: any CourseCatalogService

    init(service: any CourseCatalogService) {
        self.service = service
    }

    var visibleCourses: [Course] {
        planner.search(searchText)
    }

    func loadCatalog() {
        do {
            planner.replaceCatalog(with: try service.fetchCourses())
            catalogState = planner.courses.isEmpty ? .empty : .loaded
        } catch {
            catalogState = .failed(error.localizedDescription)
        }
    }

    func addCourse(id: String) -> Bool {
        switch planner.addCourse(id: id) {
        case .success:
            feedbackMessage = nil
            return true
        case let .failure(error):
            feedbackMessage = error.message
            return false
        }
    }

    func removeCourse(id: String) -> Bool {
        let removed = planner.removeCourse(id: id)
        if !removed {
            feedbackMessage = "That course is not in your plan."
        } else {
            feedbackMessage = nil
        }
        return removed
    }

    func course(id: String) -> Course? {
        planner.courses.first { $0.id == id }
    }

    func clearFeedback() {
        feedbackMessage = nil
    }
}
