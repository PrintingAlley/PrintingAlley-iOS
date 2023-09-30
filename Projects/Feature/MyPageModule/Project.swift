import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MyPageModule.rawValue,
    targets: [
        .interface(module: .feature(.MyPageModule)),
        .implements(module: .feature(.MyPageModule), dependencies: [
            .feature(target: .MyPageModule, type: .interface),
            .feature(target: .SignInFeature)
        ])
    ]
)
