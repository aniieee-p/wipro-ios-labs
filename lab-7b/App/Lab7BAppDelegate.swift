import UIKit

@main
final class Lab7BAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let listViewController = CourseListViewController(courses: Course.samples)
        let navigationController = UINavigationController(rootViewController: listViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
