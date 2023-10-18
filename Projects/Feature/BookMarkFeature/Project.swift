import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.BookMarkFeature.rawValue,
    targets: [
        .interface(module: .feature(.BookMarkFeature),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.BookMarkFeature), dependencies: [
            .feature(target: .BookMarkFeature, type: .interface),
            .domain(target: .BookMarkDomain, type: .interface),
            .feature(target: .BaseFeature),
        ]),
        .testing(module: .feature(.BookMarkFeature), dependencies: [
            .feature(target: .BookMarkFeature, type: .interface)
        ]),
        .tests(module: .feature(.BookMarkFeature), dependencies: [
            .feature(target: .BookMarkFeature)
        ]),
        .demo(module: .feature(.BookMarkFeature), dependencies: [
            .feature(target: .BookMarkFeature)
        ])
    ]
)
