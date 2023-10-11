import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    targets: [
        .interface(module: .feature(.MainTabFeature)),
        .implements(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature, type: .interface),
            .feature(target: .MyPageFeature, type: .interface)
        ]),
        .demo(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature)
        ])
    ]
)
