import SwiftUI
import UIKit

@MainActor
final class LifecycleAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        LifecycleLogger.shared.record("AppDelegate: didFinishLaunching")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        LifecycleLogger.shared.record("App: willResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        LifecycleLogger.shared.record("App: didEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        LifecycleLogger.shared.record("App: willEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        LifecycleLogger.shared.record("App: didBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        LifecycleLogger.shared.record("App: willTerminate (best effort)")
    }
}

@main
struct LifecycleDemoApp: App {
    @UIApplicationDelegateAdaptor(LifecycleAppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var logger = LifecycleLogger.shared

    init() {
        LifecycleLogger.shared.record("App: SwiftUI App initialized")
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(logger)
                .onChange(of: scenePhase) { phase in
                    logger.record("Scene: \(phase.lifecycleLabel)")
                }
        }
    }
}

private extension ScenePhase {
    var lifecycleLabel: String {
        switch self {
        case .active:
            return "active"
        case .inactive:
            return "inactive"
        case .background:
            return "background"
        @unknown default:
            return "unknown"
        }
    }
}
