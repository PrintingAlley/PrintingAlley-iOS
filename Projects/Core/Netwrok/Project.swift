import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.Netwrok.rawValue,
    targets: [
        .interface(module: .core(.Netwrok)),
        .implements(module: .core(.Netwrok), dependencies: [
            .core(target: .Netwrok, type: .interface),
            .core(target: .JwtStore,type: .interface),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .UtilityModule)
        ]),
        .testing(module: .core(.Netwrok), dependencies: [
            .core(target: .Netwrok, type: .interface)
        ]),
        .tests(module: .core(.Netwrok), dependencies: [
            .core(target: .Netwrok)
        ])
    ]
)
