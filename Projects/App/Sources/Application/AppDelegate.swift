import UIKit
import FirebaseCore
import KakaoSDKCommon
import UtilityModule
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: KAKAO_NATIVE_KEY() )
        
        // configure NaverThirdPartyLoginConnection
        let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        naverInstance?.isNaverAppOauthEnable = true //네이버앱 로그인 설정
        naverInstance?.isInAppOauthEnable = true //사파리 로그인 설정
        naverInstance?.setOnlyPortraitSupportInIphone(true)
        
        naverInstance?.serviceUrlScheme = "naverlogin" //URL Scheme
        naverInstance?.consumerKey = NAVER_CLIENT_ID() //클라이언트 아이디
        naverInstance?.consumerSecret = NAVER_SECRET() //시크릿 아이디
        naverInstance?.appName = "인쇄골목" //앱이름
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
 
    }


}

