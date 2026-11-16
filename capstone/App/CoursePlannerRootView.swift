import CoursePlannerCore
import SwiftUI

enum PlannerRoute: Hashable {
    case course(String)
}

struct CoursePlannerRootView: View {
    @ObservedObject var viewModel: CoursePlannerViewModel

    var body: some View {
        NavigationStack {
            PlannerHomeView(viewModel: viewModel)
                .navigationDestination(for: PlannerRoute.self) { route in
                    switch route {
                    case let .course(id):
                        if let course = viewModel.course(id: id) {
                            CourseDetailView(course: course, viewModel: viewModel)
                        } else {
                            PlannerEmptyState(
                                title: "Course unavailable",
                                systemImage: "book.closed",
                                message: "This course is no longer in the catalog."
                            )
                        }
                    }
                }
        }
        .task {
            if viewModel.catalogState == .idle {
                viewModel.loadCatalog()
            }
        }
        .alert(
            "Planner",
            isPresented: Binding(
                get: { viewModel.feedbackMessage != nil },
                set: { if !$0 { viewModel.clearFeedback() } }
            )
        ) {
            Button("OK", role: .cancel) {
                viewModel.clearFeedback()
            }
        } message: {
            Text(viewModel.feedbackMessage ?? "")
        }
    }
}
