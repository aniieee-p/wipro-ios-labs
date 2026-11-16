import SwiftUI

@main
struct CoursePlannerApp: App {
    @StateObject private var viewModel = CoursePlannerViewModel(
        service: LocalCourseCatalogService()
    )

    var body: some Scene {
        WindowGroup {
            CoursePlannerRootView(viewModel: viewModel)
        }
    }
}
