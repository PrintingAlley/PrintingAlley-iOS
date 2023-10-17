import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    targets: [
        .interface(module: .feature(.BaseFeature)),
        .implements(module: .feature(.BaseFeature), dependencies: [
            .shared(target: .UtilityModule),
            .feature(target: .BaseFeature,type:.interface)
        ]),
        .tests(module: .feature(.BaseFeature), dependencies: [
            .feature(target: .BaseFeature)
        ])
    ]
)
