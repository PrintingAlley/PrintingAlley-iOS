import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .interface(module: .feature(.HomeFeature),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .HomeFeature, type: .interface),
            .domain(target: .TagDomain,type: .interface),
            .domain(target: .BaseDomain,type: .interface),
            .domain(target: .ContentDomain, type: .interface),
            .feature(target: .CategorySearchFeature, type: .interface)
        ]),
        .demo(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature)
        ])
    ]
)
