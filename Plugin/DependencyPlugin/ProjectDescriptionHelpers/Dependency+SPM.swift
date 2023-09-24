import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {

    static let Needle = TargetDependency.external(name: "NeedleFoundation")
    static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalyticsSwift")
    static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
}

public extension Package {
}
