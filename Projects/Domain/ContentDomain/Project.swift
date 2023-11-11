import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.ContentDomain.rawValue,
    targets: [
        .interface(module: .domain(.ContentDomain),dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.ContentDomain), dependencies: [
            .domain(target: .ContentDomain, type: .interface),
            .domain(target: .BaseDomain)
            
        ])
    ]
)
