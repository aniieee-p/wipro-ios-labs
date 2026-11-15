import SwiftUI

// The @main attribute marks this as the app's single entry point.
// AssessmentM4App conforms to the App protocol, which requires a `body`
// property returning a Scene. WindowGroup creates the main window and
// places BookListView as the first screen.

@main
struct AssessmentM4App: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
    }
}
