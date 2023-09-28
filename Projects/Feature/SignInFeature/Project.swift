import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SignInFeature.rawValue,
    targets: [
        .interface(module: .feature(.SignInFeature)),
        .implements(module: .feature(.SignInFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SignInFeature, type: .interface)
        ]),
        .testing(module: .feature(.SignInFeature), dependencies: [
            .feature(target: .SignInFeature, type: .interface)
        ]),
        .demo(module: .feature(.SignInFeature), dependencies: [
            .feature(target: .SignInFeature)
        ])
    ]
)
