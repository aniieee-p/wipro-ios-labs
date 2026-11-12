import SwiftUI

struct AboutNavigationView: View {
    var body: some View {
        Form {
            Section("NavigationStack demo") {
                Text("Choose a course to see its details. Use the back button to return to the list.")
                Text("The info button opens this screen. The Courses toolbar action on a detail screen returns directly to the list.")
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}
