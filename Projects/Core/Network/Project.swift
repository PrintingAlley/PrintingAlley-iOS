import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.Network.rawValue,
    targets: [
        .interface(module: .core(.Network)),
        .implements(module: .core(.Network), dependencies: [
            .core(target: .Network, type: .interface),
            .core(target: .JwtStore,type: .interface),
            .shared(target: .GlobalThirdPartyLibrary),
        ]),
        .testing(module: .core(.Network), dependencies: [
            .core(target: .Network, type: .interface)
        ]),
        .tests(module: .core(.Network), dependencies: [
            .core(target: .Network)
        ])
    ]
)
