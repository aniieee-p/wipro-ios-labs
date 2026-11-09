import SwiftUI

@main
struct Lab5AApp: App {
    var body: some Scene {
        WindowGroup {
            QueueDemoViewControllerHost()
                .ignoresSafeArea()
        }
    }
}

private struct QueueDemoViewControllerHost: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> QueueDemoViewController {
        QueueDemoViewController()
    }

    func updateUIViewController(_ uiViewController: QueueDemoViewController, context: Context) {}
}
