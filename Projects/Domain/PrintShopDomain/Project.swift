import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.PrintShopDomain.rawValue,
    targets: [
        .interface(module: .domain(.PrintShopDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.PrintShopDomain), dependencies: [
            .domain(target: .PrintShopDomain, type: .interface),
            .domain(target: .BaseDomain)
        ])
    ]
)
