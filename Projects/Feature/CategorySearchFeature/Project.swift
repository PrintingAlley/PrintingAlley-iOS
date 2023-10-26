import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.CategorySearchFeature.rawValue,
    targets: [
        .interface(module: .feature(.CategorySearchFeature)),
        .implements(module: .feature(.CategorySearchFeature), dependencies: [
            .feature(target: .CategorySearchFeature, type: .interface)
        ]),
        .demo(module: .feature(.CategorySearchFeature), dependencies: [
            .feature(target: .CategorySearchFeature)
        ])
    ]
)
