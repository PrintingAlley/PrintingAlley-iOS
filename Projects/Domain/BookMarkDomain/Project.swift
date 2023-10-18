import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BookMarkDomain.rawValue,
    targets: [
        .interface(module: .domain(.BookMarkDomain)),
        .implements(module: .domain(.BookMarkDomain), dependencies: [
            .domain(target: .BookMarkDomain, type: .interface)
        ])
    ]
)
