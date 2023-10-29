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
        let viewController: AlleyPageViewController = AlleyPageViewController()
        
        let vc1: UIViewController = UIViewController()
        vc1.view.backgroundColor = .black
        
        let vc2: UIViewController = UIViewController()
        vc2.view.backgroundColor = .green
        
        viewController.setTitle(["정보","리뷰"])
        viewController.setChildren([vc1,vc2])
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
