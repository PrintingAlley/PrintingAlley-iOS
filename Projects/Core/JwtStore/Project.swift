import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.JwtStore.rawValue,
    targets: [
        .interface(module: .core(.JwtStore)),
        .implements(module: .core(.JwtStore), dependencies: [
            .core(target: .JwtStore, type: .interface),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .KeychainModule)
        ]),
        .testing(module: .core(.JwtStore), dependencies: [
            .core(target: .JwtStore, type: .interface)
        ])
    ]
)
