import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SearchFeatue.rawValue,
    targets: [
        .interface(module: .feature(.SearchFeatue)),
        .implements(module: .feature(.SearchFeatue), dependencies: [
            .feature(target: .SearchFeatue, type: .interface)
        ]),
        .testing(module: .feature(.SearchFeatue), dependencies: [
            .feature(target: .SearchFeatue, type: .interface)
        ]),
        .demo(module: .feature(.SearchFeatue), dependencies: [
            .feature(target: .SearchFeatue)
        ])
    ]
)
