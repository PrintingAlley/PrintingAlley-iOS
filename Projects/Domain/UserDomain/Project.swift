import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.UserDomain.rawValue,
    targets: [
        .interface(module: .domain(.UserDomain),dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.UserDomain), dependencies: [
            .domain(target: .UserDomain, type: .interface),
            .domain(target: .BaseDomain)
        ])
    ]
)
