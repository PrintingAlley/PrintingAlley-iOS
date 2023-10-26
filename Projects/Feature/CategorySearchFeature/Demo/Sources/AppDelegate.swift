import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = CategorySearchViewController(viewModel: CategorySearchViewModel(title: "엽서/카드", id: 0))
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
