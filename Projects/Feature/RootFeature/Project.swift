import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.RootFeature.rawValue,
    targets: [
        .implements(module: .feature(.RootFeature),dependencies: [
            .feature(target: .MainTabFeature),
            .feature(target: .HomeFeature),
            .feature(target: .MyPageFeature),
            .feature(target: .NearByMeFeature),
            .feature(target: .SearchFeatue)
        ])
    ]
)
