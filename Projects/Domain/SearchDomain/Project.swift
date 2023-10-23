import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.SearchDomain.rawValue,
    targets: [
        .interface(module: .domain(.SearchDomain)),
        .implements(module: .domain(.SearchDomain), dependencies: [
            .domain(target: .SearchDomain, type: .interface)
        ])
    ]
)
