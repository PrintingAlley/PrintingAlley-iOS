import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue,
    targets: [
        .implements(module: .shared(.GlobalThirdPartyLibrary), product: .framework, dependencies: [
            .SPM.Needle,
            .SPM.FirebaseAnalytics,
            .SPM.FirebaseCrashlytics,
            .SPM.NaverLogin,
            .SPM.KakaoLogin,
            .SPM.GoogleLogin,
            .SPM.KakaoAuth,
            .SPM.Moya,
            .SPM.SnapKit,
            .SPM.Then,
            .SPM.Kingfisher,
            .SPM.RxSwift,
            .SPM.RxCocoa,
            .SPM.RxRelay,
            .SPM.RxDataSource,
            .SPM.RxKeyBoard,
            .SPM.FloatingPanel,
            .SPM.SwiftEntryKit,
            .SPM.NaverMap,
            .SPM.SVGKit
            .SPM.Lottie
        ])
    ]
)
