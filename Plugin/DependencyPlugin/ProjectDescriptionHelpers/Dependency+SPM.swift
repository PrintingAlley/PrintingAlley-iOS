import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {

    static let Needle = TargetDependency.external(name: "NeedleFoundation")
    static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalyticsSwift")
    static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
    static let NaverLogin = TargetDependency.external(name: "naveridlogin-ios-sp")
    static let GoogleLogin = TargetDependency.external(name: "GoogleSignIn")
    static let KakaoLogin = TargetDependency.external(name: "RxKakaoSDKUser")
    static let KakaoAuth = TargetDependency.external(name: "RxKakaoSDKAuth")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Then = TargetDependency.external(name: "Then")
    static let Moya = TargetDependency.external(name: "RxMoya")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    
}

public extension Package {
}
