import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.TagDomain.rawValue,
    targets: [
        .interface(module: .domain(.TagDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.TagDomain), dependencies: [
            .domain(target: .TagDomain, type: .interface),
            .domain(target: .BaseDomain)
        ])
    ]
)
