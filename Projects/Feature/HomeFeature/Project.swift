import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .interface(module: .feature(.HomeFeature)),
        .implements(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature, type: .interface)
        ]),
        .demo(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature)
        ])
    ]
)
