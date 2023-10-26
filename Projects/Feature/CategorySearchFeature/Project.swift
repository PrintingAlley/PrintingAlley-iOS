import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.CategorySearchFeature.rawValue,
    targets: [
        .interface(module: .feature(.CategorySearchFeature),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.CategorySearchFeature), dependencies: [
            .feature(target: .CategorySearchFeature, type: .interface),
            .feature(target: .BaseFeature),
            .domain(target: .TagDomain, type: .interface),
            .domain(target: .SearchDomain, type: .interface),
        ]),
        .demo(module: .feature(.CategorySearchFeature), dependencies: [
            .feature(target: .CategorySearchFeature),
            .domain(target: .TagDomain, type: .interface),
            .domain(target: .SearchDomain, type: .interface),
        ])
    ]
)
