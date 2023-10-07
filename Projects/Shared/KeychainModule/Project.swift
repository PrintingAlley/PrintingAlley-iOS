import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.KeychainModule.rawValue,
    targets: [
        .interface(module: .shared(.KeychainModule)),
        .implements(module: .shared(.KeychainModule), dependencies: [
            .shared(target: .KeychainModule, type: .interface)
        ])
    ]
)
