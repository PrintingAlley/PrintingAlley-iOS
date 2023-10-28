import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ReviewViewController(viewModel: ReviewViewModel(testDS: TestDataSourceImpl()))
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
