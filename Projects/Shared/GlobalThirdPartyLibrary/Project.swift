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
            .SPM.GoogleLogin
        ])
    ]
)
