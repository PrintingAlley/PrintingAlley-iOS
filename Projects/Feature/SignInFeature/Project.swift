import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SignInFeature.rawValue,
    targets: [
        .interface(module: .feature(.SignInFeature),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.SignInFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SignInFeature, type: .interface),
            .domain(target: .AuthDomain,type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .testing(module: .feature(.SignInFeature), dependencies: [
            .feature(target: .SignInFeature, type: .interface)
        ]),
        .demo(module: .feature(.SignInFeature), dependencies: [
            .feature(target: .SignInFeature)
        ])
    ]
)
