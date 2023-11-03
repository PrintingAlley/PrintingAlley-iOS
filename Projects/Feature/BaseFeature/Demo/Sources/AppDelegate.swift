import UIKit
import KakaoSDKCommon
import UtilityModule

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ProductDetailViewController(viewModel: ProductDetailViewModel(id: 0))
        


        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
