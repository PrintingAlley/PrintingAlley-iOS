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
        let viewController = AlleyPageViewController(viewModel: AlleyPageViewModel(titles: ["라클","라클2"]))
        
        let vc1 = UIViewController()
        
        vc1.view.backgroundColor = .red
        
        let vc2 = UIViewController()
        
        vc1.view.backgroundColor = .yellow
        
        viewController.setChildren([vc1, vc2])
        

        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
