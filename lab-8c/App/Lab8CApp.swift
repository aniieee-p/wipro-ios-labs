import CourseStateCore
import SwiftUI

@main
@MainActor
struct Lab8CApp: App {
    @StateObject private var library = CourseLibrary()

    var body: some Scene {
        WindowGroup {
            CourseListView(library: library)
        }
    }
}
