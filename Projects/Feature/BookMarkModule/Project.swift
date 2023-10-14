import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.BookMarkModule.rawValue,
    targets: [
        .interface(module: .feature(.BookMarkModule)),
        .implements(module: .feature(.BookMarkModule), dependencies: [
            .feature(target: .BookMarkModule, type: .interface)
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
