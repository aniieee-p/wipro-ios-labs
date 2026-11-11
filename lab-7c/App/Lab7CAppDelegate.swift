import UIKit

@main
final class Lab7CAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let root = SettingsViewController()
        window.rootViewController = UINavigationController(rootViewController: root)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
