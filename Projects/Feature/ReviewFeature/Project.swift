import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ReviewFeature.rawValue,
    targets: [
        .interface(module: .feature(.ReviewFeature),dependencies: []),
        .implements(module: .feature(.ReviewFeature), dependencies: [
            .feature(target: .ReviewFeature, type: .interface),
            .feature(target: .BaseFeature)
        ]),
        .demo(module: .feature(.ReviewFeature), dependencies: [
            .feature(target: .ReviewFeature)
        ])
    ]
)
