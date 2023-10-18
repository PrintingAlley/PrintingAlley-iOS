import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.BookMarkModule.rawValue,
    targets: [
        .interface(module: .feature(.BookMarkModule),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.BookMarkModule), dependencies: [
            .feature(target: .BookMarkModule, type: .interface),
            .domain(target: .BookMarkDomain, type: .interface)
            .feature(target: .BaseFeature),
        ]),
        .testing(module: .feature(.BookMarkModule), dependencies: [
            .feature(target: .BookMarkModule, type: .interface)
        ]),
        .tests(module: .feature(.BookMarkModule), dependencies: [
            .feature(target: .BookMarkModule)
        ]),
        .demo(module: .feature(.BookMarkModule), dependencies: [
            .feature(target: .BookMarkModule)
        ])
    ]
)
