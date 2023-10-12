import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    targets: [
        .interface(module: .feature(.MainTabFeature),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature, type: .interface),
            .feature(target: .MyPageFeature, type: .interface),
            .feature(target: .HomeFeature, type: .interface),
            .feature(target: .NearByMeFeature, type: .interface),
            .feature(target: .BaseFeature)
        ]),
        .demo(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature)
        ])
    ]
)
