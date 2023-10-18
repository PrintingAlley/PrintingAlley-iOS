import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BookMarkDomain.rawValue,
    targets: [
        .interface(module: .domain(.BookMarkDomain),dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.BookMarkDomain), dependencies: [
            .domain(target: .BookMarkDomain, type: .interface),
            .domain(target: .BaseDomain)
        ])
    ]
)
