import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SearchFeatue.rawValue,
    targets: [
        .interface(module: .feature(.SearchFeatue), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.SearchFeatue), dependencies: [
            .feature(target: .SearchFeatue, type: .interface),
            .feature(target: .BaseFeature),
            .domain(target: .PrintShopDomain, type: .interface)
        ]),
        .demo(module: .feature(.SearchFeatue), dependencies: [
            .feature(target: .SearchFeatue)
        ])
    ]
)
