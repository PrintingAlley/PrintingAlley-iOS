import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.ProductDomain.rawValue,
    targets: [
        .interface(module: .domain(.ProductDomain),dependencies: [
            .domain(target: .BaseDomain, type: .interface),
            
        ]),
        .implements(module: .domain(.ProductDomain), dependencies: [
            .domain(target: .ProductDomain, type: .interface),
            .domain(target: .BaseDomain),
            .domain(target: .PrintShopDomain, type: .interface),
            .domain(target: .UserDomain,type:.interface)
        ])
    ]
)
